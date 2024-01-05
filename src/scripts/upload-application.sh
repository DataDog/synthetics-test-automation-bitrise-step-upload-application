RunTests() {
    PARAM_API_KEY=$(eval echo "\$$PARAM_API_KEY")
    PARAM_APP_KEY=$(eval echo "\$$PARAM_APP_KEY")

    if [[ -n "${DD_SITE}" ]]; then
        PARAM_SITE=${DD_SITE}
    fi

    DATADOG_CI_VERSION="2.25.0"

    # Not run when running unit tests.
    if [[ -z "${DATADOG_CI_COMMAND}" ]]; then
        curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_linux-x64" --output "./datadog-ci"
        chmod +x ./datadog-ci

        DATADOG_CI_COMMAND="./datadog-ci"
    fi

    args=()
    if [[ -n $PARAM_CONFIG_PATH ]]; then
        args+=(--config "${PARAM_CONFIG_PATH}")
    fi

    if [[ -n $PARAM_VERSION_NAME ]]; then
        args+=(--versionName "${PARAM_VERSION_NAME}")
    fi
    
    if [[ -n $PARAM_LATEST ]]; then
        args+=(--latest "${PARAM_LATEST}")
    fi
    
    if [[ -n $PARAM_MOBILE_APPLICATION_ID ]]; then
        args+=(--mobileApplicationId "${PARAM_MOBILE_APPLICATION_ID}")
    fi

    if [[ -n $PARAM_MOBILE_APPLICATION_VERSION_FILE_PATH ]]; then
        args+=(--mobileApplicationVersionFilePath "${PARAM_MOBILE_APPLICATION_VERSION_FILE_PATH}")
    fi

    DATADOG_API_KEY="${PARAM_API_KEY}" \
    DATADOG_APP_KEY="${PARAM_APP_KEY}" \
    DATADOG_SITE="${PARAM_SITE}" \
    DATADOG_SYNTHETICS_CI_TRIGGER_APP="bitrise_step" \
        $DATADOG_CI_COMMAND synthetics upload-application \
        "${args[@]}"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [ $BITRISE_TEST_ENV != true ]; then
    RunTests
fi
