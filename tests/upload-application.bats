# Runs prior to every test
setup() {
    # Load our script file.
    export BITRISE_TEST_ENV=true
    source ./upload-application.sh
    unset BITRISE_TEST_ENV
}

DIFF_ARGS="-u --label actual --label expected"

@test 'Use custom parameters' {
    export api_key="DD_API_KEY"
    export app_key="DD_APP_KEY"
    export config_path="./some/other/path.json"
    export latest=true
    export mobile_application_id="123-123-123"
    export mobile_application_version_file_path="example/test.apk"
    export site="datadoghq.eu"
    export version_name="example 1.0"
    export DATADOG_CI_COMMAND="echo"

    # diff $DIFF_ARGS <(RunTests) <(echo synthetics upload-application --config ./some/other/path.json --mobileApplicationId '123-123-123' --mobileApplicationVersionFilePath "example/test.apk" --versionName 'example 1.0' --latest)
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --public-id 7uk-gte-ywv --failOnTimeout)
}

@test 'Use default parameters' {
    export api_key="DD_API_KEY"
    export app_key="DD_APP_KEY"
    export config_path=""
    export latest=false
    export mobile_application_id=""
    export mobile_application_version_file_path=""
    export site=""
    export version_name=""
    export DATADOG_CI_COMMAND="echo"

    # diff $DIFF_ARGS <(RunTests) <(echo synthetics upload-application)
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --public-id 7uk-gte-ywv --failOnTimeout)
}
