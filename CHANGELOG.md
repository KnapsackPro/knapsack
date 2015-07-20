### unreleased

* TODO

### 1.3.0

* Add knapsack binary

    https://github.com/ArturT/knapsack/pull/21

https://github.com/ArturT/knapsack/compare/v1.2.1...v1.3.0

### 1.2.1

* Add support for Turnip features

    https://github.com/ArturT/knapsack/pull/19

https://github.com/ArturT/knapsack/compare/v1.2.0...v1.2.1

### 1.2.0

* Add minitest adapter.
* Fix bug with missing global time execution when tests took less than second.

https://github.com/ArturT/knapsack/compare/v1.1.1...v1.2.0

### 1.1.1

* Use `system` instead of `exec` in rake tasks so we can return exit code from command.

https://github.com/ArturT/knapsack/compare/v1.1.0...v1.1.1

### 1.1.0

* Add support for Buildkite.com ENV variables `BUILDKITE_PARALLEL_JOB_COUNT` and `BUILDKITE_PARALLEL_JOB`.

### 1.0.4

* Pull request #12 - Raise error when CI_NODE_INDEX >= CI_NODE_TOTAL

    https://github.com/ArturT/knapsack/pull/12

### 1.0.3

* Fix bug #11 - Track properly time when using Timecop gem in tests.

    https://github.com/ArturT/knapsack/issues/11

    https://github.com/ArturT/knapsack/issues/9

### 1.0.2

* Fix bug #8 - Sort all tests just in case to avoid wrong order of files when running tests on machines where `Dir.glob` has different implementation.

### 1.0.1

* Fix bug - Add support for Cucumber Scenario Outline.

### 1.0.0

* Add cucumber support.
* Rename environment variable KNAPSACK_SPEC_PATTERN to KNAPSACK_TEST_FILE_PATTERN.
* Default name of knapsack report json file is based on adapter name so for RSpec the default report name is `knapsack_rspec_report.json` and for Cucumber the report name is `knapsack_cucumber_report.json`.

### 0.5.0

* Allow passing arguments to rspec via knapsack:rspec task.

### 0.4.0

* Add support for RSpec 2.

### 0.3.0

* Add support for semaphoreapp.com thread ENV variables.

### 0.2.0

* Add knapsack logger. Allow to use custom logger.

### 0.1.4

* Fix wrong time presentation for negative seconds.

### 0.1.3

* Better time presentation instead of seconds.

### 0.1.2

* Fix case when someone removes spec file which exists in knapsack report.
* Extract config to separate class and fix wrong node time execution on CI.

### 0.1.1

* Fix assigning time execution to right spec file when call RSpec shared example.

### 0.1.0

* Gem ready to use it!

### 0.0.3

* Test release. Not ready to use it.
