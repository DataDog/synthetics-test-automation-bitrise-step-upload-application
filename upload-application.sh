UploadApplication() {
    if [[ -n "${DD_SITE}" ]]; then
        site=${DD_SITE}
    fi

    DATADOG_CI_VERSION="2.36.0"

    unamestr=$(uname)

    # Not run when running unit tests.
    if [[ -z "${DATADOG_CI_COMMAND}" ]]; then
        if [[ "$unamestr" == 'Darwin' ]]; then
            curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_darwin-x64" --output "./datadog-ci"
        elif [[ "$unamestr" == 'Linux' ]]; then
            curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_linux-x64" --output "./datadog-ci"
        fi
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

    output=$(DATADOG_API_KEY="${api_key}" \
    DATADOG_APP_KEY="${app_key}" \
    DATADOG_SUBDOMAIN="app" \
    DATADOG_SITE="${site}" \
    DATADOG_SYNTHETICS_CI_TRIGGER_APP="bitrise_step" \
        $DATADOG_CI_COMMAND synthetics upload-application \
        "${args[@]}")

    command_exit_code=$?
    echo $output

    if [[ $output =~ ([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$ ]]; then
        version_id=${BASH_REMATCH[1]}
        echo "Extracted Version ID: $version_id (can be referenced with \$DATADOG_UPLOADED_APPLICATION_VERSION_ID)"
        envman add --key DATADOG_UPLOADED_APPLICATION_VERSION_ID --value "$version_id"
    else
        echo "No Version ID found in the output."
    fi

    exit $command_exit_code
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [ "$IS_TEST_ENV" != "true" ]; then
    UploadApplication
fi
