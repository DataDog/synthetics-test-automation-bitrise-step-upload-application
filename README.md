# Datadog Continuous Testing for Bitrise

![GitHub Release](https://img.shields.io/github/v/release/DataDog/synthetics-test-automation-bitrise-step-upload-application)
[![Build Status](https://app.bitrise.io/app/2d252b25-8c31-427b-98e8-1d0b2bc484c1/status.svg?token=CiGeaNblC2veLBtAbTgmLQ&branch=main)](https://app.bitrise.io/app/2d252b25-8c31-427b-98e8-1d0b2bc484c1)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Overview

With the `synthetics-test-automation-bitrise-step-upload-application` step, you can upload a new version of your application to Datadog to run Synthetic tests against during your Bitrise CI, ensuring that all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle.

This step requires that your application already exists in Datadog.

For more information on the available configuration, see the [`datadog-ci upload-application` documentation][2].

## Setup

This step is not available on the official Bitrise Step Library.
To get started:

1. Add the following git URL to your workflow. See the [official Bitrise documentation][3] on how to do that though the Bitrise app. You can also configure it locally by referencing the git URL in your `bitrise.yml` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-upload-application.git@v1.13.0:
```

2. Add your API and application keys to your [secrets in Bitrise][4].
3. [Configure your step inputs][5]. You can also configure them in your `bitrise.yml` file. The only required inputs are the two secrets you configured earlier. For a comprehensive list of inputs, see the [Inputs section](#inputs).

## How to use this step locally

You can run this step directly using the [Bitrise CLI][6].

To run this step locally:

1. Open your terminal or command line.
2. `git clone` the [Bitrise repository][6].
3. `cd` into the directory of the step (the one you just `git clone`d).
4. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`. The `.bitrise.secrets.yml` file is a Git-ignored file, so you can store your secrets in it.
5. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`.
6. Once you have the required secret parameters in your `.bitrise.secrets.yml` file, run this step with the [Bitrise CLI][6] with `bitrise run test`.

An example `.bitrise.secrets.yml` file:

```yml
envs:
- A_SECRET_PARAM_ONE: the value for secret one
- A_SECRET_PARAM_TWO: the value for secret two
```

## Usage

### Example task using a global configuration override with `configPath`

This task overrides the path to the global `datadog-ci.config.json` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-upload-application.git@v1.13.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - config_path: './synthetics-config.json'
```

### Example including all possible configurations

For reference, this is an example of a complete configuration:

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-upload-application.git@v1.13.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - config_path: './global.config.json'
   - latest: true
   - mobile_application_id: '123-123-123'
   - mobile_application_version_file_path: 'path/to/application.apk'
   - site: 'datadoghq.com'
   - version_name: 'example 1.0'
```

## Inputs

For more information on the available configuration, see the [`datadog-ci upload-application` documentation][2].

| Name                                   | Description                                                                                                                                                                      |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `api_key`                              | (**Required**) Your Datadog API key. This key is [created in your Datadog organization][8] and should be stored as a secret.                                                     |
| `app_key`                              | (**Required**) Your Datadog application key. This key is [created in your Datadog organization][8] and should be stored as a secret.                                             |
| `config_path`                          | The path to the [global configuration file][9] that configures datadog-ci. <br><sub>**Default:** `datadog-ci.json`</sub>                                                         |
| `latest`                               | Mark the new version as `latest`. Any tests that run on the latest version will use this version on their next run. <br><sub>**Default:** `false`</sub>                          |
| `mobile_application_id`                | (**Required**) The ID of the application you want to upload the new version to.                                                                                                  |
| `mobile_application_version_file_path` | (**Required**) The path to the new version of your mobile application (`.apk` or `.ipa`). You may use `$BITRISE_IPA_PATH` or `$BITRISE_APK_PATH` from your previous build steps. |
| `site`                                 | Your Datadog site. The possible values are listed [in this table][14]. <br><sub>**Default:** `datadoghq.com`</sub>                                                               |
| `version_name`                         | (**Required**) The name of the new version. It has to be unique.                                                                                                                 |

## Outputs

| Name                                      | Description                                                                                                                                                                                             |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DATADOG_UPLOADED_APPLICATION_VERSION_ID` | The version ID of the application that was just uploaded. Pass it to the [`datadog-mobile-app-run-tests` step][10] with the `mobile_application_version` input to test this version of the application. |

## Further reading

Additional helpful documentation, links, and articles:

- [Getting Started with Continuous Testing][13]
- [Continuous Testing and CI/CD Configuration][11]
- [Best practices for continuous testing with Datadog][12]

[2]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#upload-application-command
[3]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html#adding-steps-from-alternative-sources
[4]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[5]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html
[6]: https://github.com/bitrise-io/bitrise
[8]: https://docs.datadoghq.com/account_management/api-app-keys/
[9]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file
[10]: https://bitrise.io/integrations/steps/datadog-mobile-app-run-tests
[11]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[12]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
[13]: https://docs.datadoghq.com/getting_started/continuous_testing/
[14]: https://docs.datadoghq.com/getting_started/site/#access-the-datadog-site
