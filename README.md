# Datadog Continuous Testing for Bitrise

<!-- TODO add link to marketplace after we publish the step -->
<!-- [![Visual Studio Marketplace Version]()][A-1]  -->
[![Build Status](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4/status.svg?token=480MdFpG78E6kZASg5w1dw&branch=main)](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Overview

With the `synthetics-test-automation-bitrise-step-upload-application` step you can upload a new version of your application to Datadog to run Synthetics tests against during your Bitrise CI and ensure all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle. This step uses the [Datadog CI Synthetics command][B-2]. Your application already needs to exist for this to work.

## Setup

To get started:

1. Add this step to your workflow. You can see Bitrise's documentation on how to do that [here][D-1]. You can also configure it locally by referencing this step in your `bitrise.yml`.
2. Add you API and App Keys to your secrets in Bitrise. Documentation on how to do that can be found [here][D-2].
3. Configure your step inputs ([docs][D-3]). You can also configure them in your `bitrise.yml`. The only required inputs are the 2 secrets you configured earlier. The rest of the possible inputs will be described later on.

## How to use this Step locally

This Step can be run directly with the [bitrise CLI][B-3].

To get sterted:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
7. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI][B-3]: `bitrise run test`

An example `.bitrise.secrets.yml` file:

```
envs:
- A_SECRET_PARAM_ONE: the value for secret one
- A_SECRET_PARAM_TWO: the value for secret two
```

## Usage

### Example task using a global configuration override with `configPath`

<!-- TODO: change git urls to step references after we publish it -->
This task overrides the path to the global `datadog-ci.config.json` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - config_path: './synthetics-config.json'
```

For an example configuration file, see this [`global.config.json` file][B-1].

### Example including all possible configurations

For reference here's how a full configuration could look like:

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - config_path: './global.config.json'
   - latest: true
   - mobile_application_version_id: '123-123-123'
   - mobile_application_version_file_path: 'path/to/application.apk'
   - site: 'datadoghq.com'
   - version_name: 'example 1.0'
```


## Inputs

| Name                               | Requirement | Description                                                                                                                            |
| -----------------------------------| :---------: | ---------------------------------------------------------------------------------------------------------------------------------------|
| `apiKey`                           | _required_  | Your Datadog API key. This key is created by your [Datadog organization][C-3] and will be accessed as an environment variable.         |
| `appKey`                           | _required_  | Your Datadog application key. This key is created by your [Datadog organization][C-3] and will be accessed as an environment variable. |
| `configPath`                       | _optional_  | The global JSON configuration is used when launching tests. See the [example configuration][C-2] for more details.                     |
| `latest`                           | _optional_  | Marks the application as `latest`. Any tests that run on the latest version will use this version on their next run.                   |
| `mobileApplicationVersionId`       | _optional_  | ID of the application you want to upload the new version to.                                                                           |
| `mobileApplicationVersionFilePath` | _optional_  | Override the application version for Synthetic mobile application tests.                                                               |
| `site`                             | _optional_  | The Datadog site to send data to. If the `DD_SITE` environment variable is set, it takes precedence.                                   |
| `versionName`                      | _optional_  | Name of the new version. It has to be unique.                                                                                          |

## Further reading

Additional helpful documentation, links, and articles:

- [Continuous Testing and CI/CD Configuration][C-1]
- [Best practices for continuous testing with Datadog][E-1]

<!-- Links to Marketplace -->
[A-1]: https://marketplace.visualstudio.com/items?itemName=Datadog.datadog-ci

<!-- Github links -->
[B-1]: https://github.com/DataDog/datadog-ci/blob/master/.github/workflows/e2e/global.config.json
[B-2]: https://github.com/DataDog/datadog-ci/tree/master/src/commands/synthetics#test-files
[B-3]: https://github.com/bitrise-io/bitrise

<!-- Links to datadog documentation -->
[C-1]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[C-2]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file-options
[C-3]: https://docs.datadoghq.com/account_management/api-app-keys/

<!-- Integration specific links -->
[D-1]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html
[D-2]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[D-3]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html

<!-- Other -->
[E-1]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
