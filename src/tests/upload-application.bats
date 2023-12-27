# Runs prior to every test
setup() {
    # Load our script file.
    export BITRISE_TEST_ENV=true
    source ./src/scripts/run-tests.sh 
    export BITRISE_TEST_ENV=false  # put this here with the idea that it would set the env var to false after the tests are run so that if i run just the shell script after it will actaully run it
}

DIFF_ARGS="-u --label actual --label expected"

@test 'Use custom parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH="./some/other/path.json"
    export PARAM_SITE="datadoghq.eu"
    export PARAM_SUBDOMAIN="app1"
    export DATADOG_CI_COMMAND="echo"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --failOnCriticalErrors --failOnMissingTests --no-failOnTimeout --tunnel --config ./some/other/path.json --files test1.json --jUnitReport reports/TEST-1.xml --pollingTimeout 123 --public-id jak-not-now --public-id jak-one-mor --search apm --variable START_URL=https://example.org --variable MY_VARIABLE=\"My title\")
}

@test 'Use default parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH=""
    export PARAM_SITE=""
    export PARAM_SUBDOMAIN=""
    export DATADOG_CI_COMMAND="echo"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --failOnTimeout)
}

@test 'Support spaces and commas in filenames' {
    export DATADOG_CI_COMMAND="echo"

    export PARAM_FILES="ci/file with space.json"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "ci/file with space.json")

    export PARAM_FILES="{,!(node_modules)/**/}*.synthetics.json"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "{,!(node_modules)/**/}*.synthetics.json")

    export PARAM_FILES="hello, i'm a file.txt"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "hello, i'm a file.txt")

    export PARAM_FILES=$'file 1.json\nfile 2.json'
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "file 1.json" --files "file 2.json")
}
