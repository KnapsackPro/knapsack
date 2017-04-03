### unreleased

* TODO

### 1.13.3

* Fix: Trailing slash should be removed from allocator test_dir.

    https://github.com/ArturT/knapsack/issues/57

https://github.com/ArturT/knapsack/compare/v1.13.2...v1.13.3

### 1.13.2

* Add support for test files in directory with spaces.

    Related:
    https://github.com/KnapsackPro/knapsack_pro-ruby/issues/27

https://github.com/ArturT/knapsack/compare/v1.13.1...v1.13.2

### 1.13.1

* Fix: Get rid of call #zero? method on $?.exitstatus in test runners tasks

    https://github.com/ArturT/knapsack/pull/52

https://github.com/ArturT/knapsack/compare/v1.13.0...v1.13.1

### 1.13.0

* Add KNAPSACK_LOG_LEVEL option

    https://github.com/ArturT/knapsack/pull/49

https://github.com/ArturT/knapsack/compare/v1.12.2...v1.13.0

### 1.12.2

* Fix support for turnip >= 2.x

    https://github.com/ArturT/knapsack/pull/47

https://github.com/ArturT/knapsack/compare/v1.12.1...v1.12.2

### 1.12.1

* Cucumber and Spinach should load files from proper folder in case when you use custom test directory.

https://github.com/ArturT/knapsack/compare/v1.12.0...v1.12.1

### 1.12.0

* Add support for Minitest::SharedExamples

    https://github.com/ArturT/knapsack/pull/46

https://github.com/ArturT/knapsack/compare/v1.11.1...v1.12.0

### 1.11.1

* Require spinach in spec helper so tests will pass but don't require it in spinach adapter because it breaks for users who don't use spinach and they don't want to add it to their Gemfile

    Related PR:
    https://github.com/ArturT/knapsack/pull/41

https://github.com/ArturT/knapsack/compare/v1.11.0...v1.11.1

### 1.11.0

* Add support for Spinach

    https://github.com/ArturT/knapsack/pull/41

https://github.com/ArturT/knapsack/compare/v1.10.0...v1.11.0

### 1.10.0

* Log the time offset warning at INFO if time not exceeded

    https://github.com/ArturT/knapsack/pull/40

https://github.com/ArturT/knapsack/compare/v1.9.0...v1.10.0

### 1.9.0

* Use Knapsack.logger for runner output

    https://github.com/ArturT/knapsack/pull/39

https://github.com/ArturT/knapsack/compare/v1.8.0...v1.9.0

### 1.8.0

* Add support for older cucumber versions than 1.3

    https://github.com/KnapsackPro/knapsack_pro-ruby/issues/5

https://github.com/ArturT/knapsack/compare/v1.7.0...v1.8.0

### 1.7.0

* Add ability to run tests from multiple directories

    https://github.com/ArturT/knapsack/pull/35

https://github.com/ArturT/knapsack/compare/v1.6.1...v1.7.0

### 1.6.1

* Changed rake task in minitest_runner.rb to have no warnings output

    https://github.com/KnapsackPro/knapsack_pro-ruby/pull/4

https://github.com/ArturT/knapsack/compare/v1.6.0...v1.6.1

### 1.6.0

* Add support for Cucumber 2

    https://github.com/ArturT/knapsack/issues/30

https://github.com/ArturT/knapsack/compare/v1.5.1...v1.6.0

### 1.5.1

* Add link to FAQ at the end of time offset warning

https://github.com/ArturT/knapsack/compare/v1.5.0...v1.5.1

### 1.5.0

* Add support for snap-ci.com

https://github.com/ArturT/knapsack/compare/v1.4.1...v1.5.0

### 1.4.1

* Update test file pattern in tests also. Related PR https://github.com/ArturT/knapsack/pull/27
* Ensure there are no duplicates in leftover tests because of new test file pattern

https://github.com/ArturT/knapsack/compare/v1.4.0...v1.4.1

### 1.4.0

* Rename RspecAdapter to RSpecAdapter so that it is consistent

    https://github.com/ArturT/knapsack/pull/28

* Change file path patterns to support 1-level symlinks by default

    https://github.com/ArturT/knapsack/pull/27

https://github.com/ArturT/knapsack/compare/v1.3.4...v1.4.0

### 1.3.4

* Make knapsack backwards compatible with earlier version of minitest

    https://github.com/ArturT/knapsack/pull/26

https://github.com/ArturT/knapsack/compare/v1.3.3...v1.3.4

### 1.3.3

* Fix wrong dependency for timecop

https://github.com/ArturT/knapsack/compare/v1.3.2...v1.3.3

### 1.3.2

* Use Timecop as dependency and always use Time.now_without_mock_time to avoid problem when someone did stub on Time without using Timecop.
* Don't exit on successful RSpec and Cucumber runs

    https://github.com/ArturT/knapsack/pull/25

https://github.com/ArturT/knapsack/compare/v1.3.1...v1.3.2

### 1.3.1

* Treat KNAPSACK_GENERATE_REPORT=false as generate_report -> false

    https://github.com/ArturT/knapsack/pull/22

https://github.com/ArturT/knapsack/compare/v1.3.0...v1.3.1

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
