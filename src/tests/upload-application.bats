# Runs prior to every test
setup() {
    # Load our script file.
    export BITRISE_TEST_ENV=true
    source ./src/scripts/uploard-application.sh 
    unset BITRISE_TEST_ENV
}

DIFF_ARGS="-u --label actual --label expected"

@test 'Use custom parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH="./some/other/path.json"
    export PARAM_LATEST=true
    export PARAM_MOBILE_APPLICATION_ID="123-123-123"
    export PARAM_MOBILE_APPLICATION_VERSION_FILE_PATH="example/test.apk"
    export PARAM_SITE="datadoghq.eu"
    export PARAM_VERSION_NAME="example 1.0"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics upload-application --config ./some/other/path.json --mobileApplicationId '123-123-123' --mobileApplicationVersionFilePath "example/test.apk" --versionName 'example 1.0' --latest)
}

@test 'Use default parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH=""
    export PARAM_LATEST=false
    export PARAM_MOBILE_APPLICATION_ID=""
    export PARAM_MOBILE_APPLICATION_VERSION_FILE_PATH=""
    export PARAM_SITE=""
    export PARAM_VERSION_NAME=""

    diff $DIFF_ARGS <(RunTests) <(echo synthetics upload-application)
}
