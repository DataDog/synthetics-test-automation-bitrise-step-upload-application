# Datadog Continuous Testing for Bitrise

![Bitrise](https://img.shields.io/bitrise/datadog-mobile-app-upload)
[![Build Status](https://app.bitrise.io/app/2d252b25-8c31-427b-98e8-1d0b2bc484c1/status.svg?token=CiGeaNblC2veLBtAbTgmLQ&branch=main)](https://app.bitrise.io/app/2d252b25-8c31-427b-98e8-1d0b2bc484c1)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Overview

With the `synthetics-test-automation-bitrise-step-upload-application` step, you can upload a new version of your application to Datadog to run Synthetics tests against during your Bitrise CI and ensure all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle. This step uses the [Datadog CI Synthetics command][2002]. Your application already needs to exist for this to work.

## Setup

To get started:

1. Add this step to your workflow. You can see [Bitrise's documentation][4001] on how to do that. You can also configure it locally by referencing this step in your `bitrise.yml`.
2. Add your API and App keys to your secrets in Bitrise. Documentation on how to do that can be found here: [Setting a Secret][4002].
3. Configure your step inputs (see the [Step Inputs documentation][4003]). You can also configure them in your `bitrise.yml`. The only required inputs are the two secrets you configured earlier. The rest of the possible inputs are described in a later section.

## How to use this Step locally

This Step can be run directly with the [Bitrise CLI][2003].

To get started:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
7. Once you have the required secret parameters in your `.bitrise.secrets.yml`, run this step with the [Bitrise CLI][2003]: `bitrise run test`.

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
- datadog-mobile-app-upload@1:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - config_path: './synthetics-config.json'
```

For an example configuration file, see the [`global.config.json` file][2001].

### Example including all possible configurations

For reference here's how a full configuration could look:

```yml
- datadog-mobile-app-upload@1:
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

| Name                               | Requirement | Description                                                                                                                             |
| -----------------------------------| :---------: | --------------------------------------------------------------------------------------------------------------------------------------- |
| `apiKey`                           | _required_  | Your Datadog API key. This key is created by your [Datadog organization][3003] and will be accessed as an environment variable.         |
| `appKey`                           | _required_  | Your Datadog application key. This key is created by your [Datadog organization][3003] and will be accessed as an environment variable. |
| `configPath`                       | _optional_  | The global JSON configuration is used when launching tests. See the [example configuration][3002] for more details.                     |
| `latest`                           | _optional_  | Marks the application as `latest`. Any tests that run on the latest version will use this version on their next run.                    |
| `mobileApplicationVersionId`       | _required_  | ID of the application you want to upload the new version to.                                                                            |
| `mobileApplicationVersionFilePath` | _required_  | Override the application version for Synthetic mobile application tests.                                                                |
| `site`                             | _optional_  | The Datadog site to send data to. If the `DD_SITE` environment variable is set, it takes precedence.                                    |
| `versionName`                      | _required_  | Name of the new version. It has to be unique.                                                                                           |

## Further reading

Additional helpful documentation, links, and articles:

- [Continuous Testing and CI/CD Configuration][3001]
- [Best practices for continuous testing with Datadog][5001]

<!-- Links to Marketplace -->
[1001]: https://bitrise.io/integrations/steps/datadog-mobile-app-upload

<!-- Github links -->
[2001]: https://github.com/DataDog/datadog-ci/blob/master/.github/workflows/e2e/global.config.json
[2002]: https://github.com/DataDog/datadog-ci/tree/master/src/commands/synthetics#test-files
[2003]: https://github.com/bitrise-io/bitrise

<!-- Links to datadog documentation -->
[3001]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[3002]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file-options
[3003]: https://docs.datadoghq.com/account_management/api-app-keys/

<!-- Integration specific links -->
[4001]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html
[4002]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[4003]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html

<!-- Other -->
[5001]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
