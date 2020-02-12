# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.21.0] - 2020-02-12
### Added
- Add support for connection headers and proxy [(#134)](https://github.com/ansible/ansible_tower_client_ruby/pull/134)
- Allow request options to be passed to Faraday [(#140)](https://github.com/ansible/ansible_tower_client_ruby/pull/140)
- Add usage documentation to the README [(#138)](https://github.com/ansible/ansible_tower_client_ruby/pull/138)

### Fixed
- Fix issue where passing no options gives a NilError [(#136)](https://github.com/ansible/ansible_tower_client_ruby/pull/136)

### Changed
- Extract MockApi responses into JSON files [(#137)](https://github.com/ansible/ansible_tower_client_ruby/pull/137)

## [0.20.2] - 2019-08-19
### Fixed
- Ensure #vault_password is never nil [(#132)](https://github.com/ansible/ansible_tower_client_ruby/pull/132)

## [0.20.1] - 2019-06-20
### Fixed
- Only attempt to find a related job if there is a reference to one [(#131)](https://github.com/ansible/ansible_tower_client_ruby/pull/131)

## [0.20.0] - 2019-05-22
### Added
- Added support for v2 API credential objects [(#123)](https://github.com/ansible/ansible_tower_client_ruby/pull/123)

## [0.19.1] - 2019-03-25
### Fixed
- Avoid redundant redirects [(#124)](https://github.com/ansible/ansible_tower_client_ruby/pull/124) [(#127)](https://github.com/ansible/ansible_tower_client_ruby/pull/127)
- Ensure a single trailing slash on URLs [(#126)](https://github.com/ansible/ansible_tower_client_ruby/pull/126)

## [0.19.0] - 2018-11-19
### Added
- Added ProjectUpdate#stdout [(#122)](https://github.com/ansible/ansible_tower_client_ruby/pull/122)

### Fixed
- Aliased ProjectUpdate#result_stdout to #stdout to work around removed attribute [(#122)](https://github.com/ansible/ansible_tower_client_ruby/pull/122)

## [0.18.0] - 2018-09-13
### Added
- Raise a helpful error message when options will be ignored in JobTemplate#launch [(#119)](https://github.com/ansible/ansible_tower_client_ruby/pull/119)

## [0.17.0] - 2018-07-27
### Removed
- Reverted support for API v2 and v2 Credentials [(#117)](https://github.com/ansible/ansible_tower_client_ruby/pull/117)

### Fixed
- Fix WorkflowJobNode#job and add tests[(#116)](https://github.com/ansible/ansible_tower_client_ruby/pull/116)

## [0.16.0] - 2018-07-06
### Added
- Added support for API v2 and v2 Credentials [(#107)](https://github.com/ansible/ansible_tower_client_ruby/pull/107)
- Added AnsibleTowerClient::WorkflowJobNode [(#109)](https://github.com/ansible/ansible_tower_client_ruby/pull/109)
- Set the Faraday logger when creating a connection [(#110)](https://github.com/ansible/ansible_tower_client_ruby/pull/110)
- Added AnsibleTowerClient::CredentialTypev2 [(#108)](https://github.com/ansible/ansible_tower_client_ruby/pull/108)
- Added AnsibleTowerClient::WorkflowJob#extra_vars_hash [(#111)](https://github.com/ansible/ansible_tower_client_ruby/pull/111)

### Changed
- Substitute invalid characters for dynamically defined class names [(#105)](https://github.com/ansible/ansible_tower_client_ruby/pull/105)

## [0.15.0] - 2018-06-05
### Added
- Added AnsibleTowerClient::WorkflowJob [(#104)](https://github.com/ansible/ansible_tower_client_ruby/pull/104)
- Added AnsibleTowerClient::WorkflowJobTemplate [(#104)](https://github.com/ansible/ansible_tower_client_ruby/pull/104)
- Added AnsibleTowerClient::WorkflowJobTemplateNode [(#104)](https://github.com/ansible/ansible_tower_client_ruby/pull/104)

## [0.14.0] - 2018-04-26
### Added
- Add Project#last_update [(#102)](https://github.com/ansible/ansible_tower_client_ruby/pull/102)

### Fixed
- Fix debug logging of non-JSON responses [(#102)](https://github.com/ansible/ansible_tower_client_ruby/pull/102)

## [0.13.0] - 2018-04-05
### Added
- Add SystemJobTemplate and Schedules [(#99)](https://github.com/ansible/ansible_tower_client_ruby/pull/99)
- Add SystemJob and SystemJobTemplate#launch [(#100)](https://github.com/ansible/ansible_tower_client_ruby/pull/100)

## [0.12.2] - 2017-05-08
### Fixed
- Check before update attribute of basemodel [(#93)](https://github.com/ansible/ansible_tower_client_ruby/pull/93)

## [0.12.1] - 2017-04-24
### Fixed
- Fix setting organization on Credential [(#92)](https://github.com/ansible/ansible_tower_client_ruby/pull/92)

## [0.12.0] - 2017-04-17
### Added
- Add Job#job_events [(#85)](https://github.com/ansible/ansible_tower_client_ruby/pull/85)

### Fixed
- Allow collection enumerator to be enumerated multiple times [(#86)](https://github.com/ansible/ansible_tower_client_ruby/pull/86)

### Removed
- Add Job#job_plays [(#85)](https://github.com/ansible/ansible_tower_client_ruby/pull/85)

## [0.11.0] - 2017-04-10
### Added
- Add ProjectUpdate and expose Project#update [(#82)](https://github.com/ansible/ansible_tower_client_ruby/pull/82)

## [0.10.0] - 2017-03-23
### Added
- Allow formatted stdout, default to plain text [(#80)](https://github.com/ansible/ansible_tower_client_ruby/pull/80)

## [0.9.0] - 2017-03-02
### Added
- Expose Plays off of a Job [(#77)](https://github.com/ansible/ansible_tower_client_ruby/pull/77)
- Expose JobEvent [(#77)](https://github.com/ansible/ansible_tower_client_ruby/pull/77)
- Expose Organization [(#79)](https://github.com/ansible/ansible_tower_client_ruby/pull/79)

## [0.8.0] - 2017-02-23
### Added
- Expose the raw hash of the object [(#74)](https://github.com/ansible/ansible_tower_client_ruby/pull/74)

### Fixed
- Override RAW attributes [(#75)](https://github.com/ansible/ansible_tower_client_ruby/pull/75)
- Inherit all errors from StandardError [(#76)](https://github.com/ansible/ansible_tower_client_ruby/pull/76)
- Fix error logging after changing error response classes [(#72)](https://github.com/ansible/ansible_tower_client_ruby/pull/72)

## [0.7.0] - 2017-02-17
### Changed
- Rescue Faraday errors and re-brand them as AnsibleTowerClient Errors [(#71)](https://github.com/ansible/ansible_tower_client_ruby/pull/71)

## [0.6.0] - 2017-02-02
### Added
- Refactor `#endpoint` [(#64)](https://github.com/ansible/ansible_tower_client_ruby/pull/64)
- Expose playbooks off of projects [(#62)](https://github.com/ansible/ansible_tower_client_ruby/pull/62)

### Changed
- Allow for alternative resource paths [(#66)](https://github.com/ansible/ansible_tower_client_ruby/pull/66)
- Raise UnlicensedFeatureError when we receive HTTP 402 [(#65)](https://github.com/ansible/ansible_tower_client_ruby/pull/65)

### Fixed
- Adjusted project_spec to test on a Project [(#63)](https://github.com/ansible/ansible_tower_client_ruby/pull/63)

[Unreleased]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.21.0...master
[0.21.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.20.2...v0.21.0
[0.20.2]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.20.1...v0.20.2
[0.20.1]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.20.0...v0.20.1
[0.20.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.19.1...v0.20.0
[0.19.1]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.19.0...v0.19.1
[0.19.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.18.0...v0.19.0
[0.18.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.17.0...v0.18.0
[0.17.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.16.0...v0.17.0
[0.16.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.15.0...v0.16.0
[0.15.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.14.0...v0.15.0
[0.14.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.13.0...v0.14.0
[0.13.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.12.2...v0.13.0
[0.12.2]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.12.1...v0.12.2
[0.12.1]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.12.0...v0.12.1
[0.12.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/ansible/ansible_tower_client_ruby/compare/v0.5.0...v0.6.0
