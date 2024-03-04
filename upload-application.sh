RunTests() {
    if [[ -n "${DD_SITE}" ]]; then
        site=${DD_SITE}
    fi

    DATADOG_CI_VERSION="2.32.0"

    # Not run when running unit tests.
    if [[ -z "${DATADOG_CI_COMMAND}" ]]; then
        curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_linux-x64" --output "./datadog-ci"
        chmod +x ./datadog-ci

        DATADOG_CI_COMMAND="./datadog-ci"
    fi

    args=()
    if [[ -n $config_path ]]; then
        args+=(--config "${config_path}")
    fi
    if [[ -n $mobile_application_id ]]; then
        args+=(--mobileApplicationId "${mobile_application_id}")
    fi
    if [[ -n $mobile_application_version_file_path ]]; then
        args+=(--mobileApplicationVersionFilePath "${mobile_application_version_file_path}")
    fi
    if [[ -n $version_name ]]; then
        args+=(--versionName "${version_name}")
    fi
    if [[ $latest == "true" ]]; then
        args+=(--latest)
    fi

    DATADOG_API_KEY="${api_key}" \
    DATADOG_APP_KEY="${app_key}" \
    DATADOG_SUBDOMAIN="app" \
    DATADOG_SITE="${site}" \
    DATADOG_SYNTHETICS_CI_TRIGGER_APP="bitrise_step" \
        $DATADOG_CI_COMMAND synthetics run-tests --public-id 7uk-gte-ywv --failOnTimeout
        # TODO: Go back to using the correct command
        # $DATADOG_CI_COMMAND synthetics upload-application \
        # "${args[@]}"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [ "$IS_TEST_ENV" != "true" ]; then
    RunTests
fi
