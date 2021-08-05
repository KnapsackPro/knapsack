### unreleased

* TODO

### 4.0.0

* __(breaking change)__ Remove support for RSpec 2.x. This change was already done by accident in [the pull request](https://github.com/KnapsackPro/knapsack/pull/107) when we added the RSpec `context` hook, which is available only since RSpec 3.x.
* Use RSpec `example` block argument instead of the global `RSpec.current_example`. This allows to run tests with the `async-rspec` gem.

    https://github.com/KnapsackPro/knapsack/pull/117

https://github.com/KnapsackPro/knapsack/compare/v3.1.0...v4.0.0

### 3.1.0

* Sorting Algorithm: round robin to least connections

    https://github.com/KnapsackPro/knapsack/pull/99

https://github.com/KnapsackPro/knapsack/compare/v3.0.0...v3.1.0

### 3.0.0

* __(breaking change)__ Require minimum Ruby 2.2 version

    https://github.com/KnapsackPro/knapsack/pull/115

* __(breaking change)__ Drop support for Minitest 4.x. Force to use minitest 5.x even on CI.

    https://github.com/KnapsackPro/knapsack/pull/114

* Replace Travis CI with GitHub Actions

    https://github.com/KnapsackPro/knapsack/pull/112

https://github.com/KnapsackPro/knapsack/compare/v2.0.0...v3.0.0

### 2.0.0

* __(breaking change)__ Ruby 2.1 is a minimum required version

    https://github.com/KnapsackPro/knapsack/pull/113

* Use Ruby 3 and add small development adjustments in codebase

    https://github.com/KnapsackPro/knapsack/pull/110

https://github.com/KnapsackPro/knapsack/compare/v1.22.0...v2.0.0

### 1.22.0

* Update time offset warning

    https://github.com/KnapsackPro/knapsack/pull/105

https://github.com/KnapsackPro/knapsack/compare/v1.21.1...v1.22.0

### 1.21.1

* Fix a bug with tracking time for pending specs in RSpec

    https://github.com/KnapsackPro/knapsack/pull/109

https://github.com/KnapsackPro/knapsack/compare/v1.21.0...v1.21.1

### 1.21.0

* Track time in before and after `:context` hooks

    https://github.com/KnapsackPro/knapsack/pull/107

https://github.com/KnapsackPro/knapsack/compare/v1.20.0...v1.21.0

### 1.20.0

* Use `Process.clock_gettime` to measure track execution time

    https://github.com/KnapsackPro/knapsack/pull/100

https://github.com/KnapsackPro/knapsack/compare/v1.19.0...v1.20.0

### 1.19.0

* Add support for Bitbucket Pipelines

    https://github.com/KnapsackPro/knapsack/pull/97

https://github.com/KnapsackPro/knapsack/compare/v1.18.0...v1.19.0

### 1.18.0

* Add support for Semaphore 2.0

    https://github.com/KnapsackPro/knapsack/pull/92

https://github.com/KnapsackPro/knapsack/compare/v1.17.2...v1.18.0

### 1.17.2

* Allow for new `bundler` in development
* Test Ruby 2.6 on CI
* Add info about Knapsack Pro Queue Mode in knapsack output
* Update URL to FAQ in knapsack output

    https://github.com/KnapsackPro/knapsack/pull/90

https://github.com/KnapsackPro/knapsack/compare/v1.17.1...v1.17.2

### 1.17.1

* Fix RSpec signal handling by replacing process

    https://github.com/KnapsackPro/knapsack/pull/86

https://github.com/KnapsackPro/knapsack/compare/v1.17.0...v1.17.1

### 1.17.0

* Add support for GitLab CI ENV variable `CI_NODE_INDEX` starting from 1.

    https://github.com/KnapsackPro/knapsack/pull/83

https://github.com/KnapsackPro/knapsack/compare/v1.16.0...v1.17.0

### 1.16.0

* Add support for Ruby >= 1.9.3.

    https://github.com/KnapsackPro/knapsack/pull/77

https://github.com/KnapsackPro/knapsack/compare/v1.15.0...v1.16.0

### 1.15.0

* Add support for Cucumber 3.

    https://github.com/KnapsackPro/knapsack/pull/68

https://github.com/KnapsackPro/knapsack/compare/v1.14.1...v1.15.0

### 1.14.1

* Update RSpec timing adapter to be more resilient.

    https://github.com/KnapsackPro/knapsack/pull/64

https://github.com/KnapsackPro/knapsack/compare/v1.14.0...v1.14.1

### 1.14.0

* Moves Timecop to development dependency.

    https://github.com/KnapsackPro/knapsack/pull/61

https://github.com/KnapsackPro/knapsack/compare/v1.13.3...v1.14.0

### 1.13.3

* Fix: Trailing slash should be removed from allocator test_dir.

    https://github.com/KnapsackPro/knapsack/issues/57

https://github.com/KnapsackPro/knapsack/compare/v1.13.2...v1.13.3

### 1.13.2

* Add support for test files in directory with spaces.

    Related:
    https://github.com/KnapsackPro/knapsack_pro-ruby/issues/27

https://github.com/KnapsackPro/knapsack/compare/v1.13.1...v1.13.2

### 1.13.1

* Fix: Get rid of call #zero? method on $?.exitstatus in test runners tasks

    https://github.com/KnapsackPro/knapsack/pull/52

https://github.com/KnapsackPro/knapsack/compare/v1.13.0...v1.13.1

### 1.13.0

* Add KNAPSACK_LOG_LEVEL option

    https://github.com/KnapsackPro/knapsack/pull/49

https://github.com/KnapsackPro/knapsack/compare/v1.12.2...v1.13.0

### 1.12.2

* Fix support for turnip >= 2.x

    https://github.com/KnapsackPro/knapsack/pull/47

https://github.com/KnapsackPro/knapsack/compare/v1.12.1...v1.12.2

### 1.12.1

* Cucumber and Spinach should load files from proper folder in case when you use custom test directory.

https://github.com/KnapsackPro/knapsack/compare/v1.12.0...v1.12.1

### 1.12.0

* Add support for Minitest::SharedExamples

    https://github.com/KnapsackPro/knapsack/pull/46

https://github.com/KnapsackPro/knapsack/compare/v1.11.1...v1.12.0

### 1.11.1

* Require spinach in spec helper so tests will pass but don't require it in spinach adapter because it breaks for users who don't use spinach and they don't want to add it to their Gemfile

    Related PR:
    https://github.com/KnapsackPro/knapsack/pull/41

https://github.com/KnapsackPro/knapsack/compare/v1.11.0...v1.11.1

### 1.11.0

* Add support for Spinach

    https://github.com/KnapsackPro/knapsack/pull/41

https://github.com/KnapsackPro/knapsack/compare/v1.10.0...v1.11.0

### 1.10.0

* Log the time offset warning at INFO if time not exceeded

    https://github.com/KnapsackPro/knapsack/pull/40

https://github.com/KnapsackPro/knapsack/compare/v1.9.0...v1.10.0

### 1.9.0

* Use Knapsack.logger for runner output

    https://github.com/KnapsackPro/knapsack/pull/39

https://github.com/KnapsackPro/knapsack/compare/v1.8.0...v1.9.0

### 1.8.0

* Add support for older cucumber versions than 1.3

    https://github.com/KnapsackPro/knapsack_pro-ruby/issues/5

https://github.com/KnapsackPro/knapsack/compare/v1.7.0...v1.8.0

### 1.7.0

* Add ability to run tests from multiple directories

    https://github.com/KnapsackPro/knapsack/pull/35

https://github.com/KnapsackPro/knapsack/compare/v1.6.1...v1.7.0

### 1.6.1

* Changed rake task in minitest_runner.rb to have no warnings output

    https://github.com/KnapsackPro/knapsack_pro-ruby/pull/4

https://github.com/KnapsackPro/knapsack/compare/v1.6.0...v1.6.1

### 1.6.0

* Add support for Cucumber 2

    https://github.com/KnapsackPro/knapsack/issues/30

https://github.com/KnapsackPro/knapsack/compare/v1.5.1...v1.6.0

### 1.5.1

* Add link to FAQ at the end of time offset warning

https://github.com/KnapsackPro/knapsack/compare/v1.5.0...v1.5.1

### 1.5.0

* Add support for snap-ci.com

https://github.com/KnapsackPro/knapsack/compare/v1.4.1...v1.5.0

### 1.4.1

* Update test file pattern in tests also. Related PR https://github.com/KnapsackPro/knapsack/pull/27
* Ensure there are no duplicates in leftover tests because of new test file pattern

https://github.com/KnapsackPro/knapsack/compare/v1.4.0...v1.4.1

### 1.4.0

* Rename RspecAdapter to RSpecAdapter so that it is consistent

    https://github.com/KnapsackPro/knapsack/pull/28

* Change file path patterns to support 1-level symlinks by default

    https://github.com/KnapsackPro/knapsack/pull/27

https://github.com/KnapsackPro/knapsack/compare/v1.3.4...v1.4.0

### 1.3.4

* Make knapsack backwards compatible with earlier version of minitest

    https://github.com/KnapsackPro/knapsack/pull/26

https://github.com/KnapsackPro/knapsack/compare/v1.3.3...v1.3.4

### 1.3.3

* Fix wrong dependency for timecop

https://github.com/KnapsackPro/knapsack/compare/v1.3.2...v1.3.3

### 1.3.2

* Use Timecop as dependency and always use Time.now_without_mock_time to avoid problem when someone did stub on Time without using Timecop.
* Don't exit on successful RSpec and Cucumber runs

    https://github.com/KnapsackPro/knapsack/pull/25

https://github.com/KnapsackPro/knapsack/compare/v1.3.1...v1.3.2

### 1.3.1

* Treat KNAPSACK_GENERATE_REPORT=false as generate_report -> false

    https://github.com/KnapsackPro/knapsack/pull/22

https://github.com/KnapsackPro/knapsack/compare/v1.3.0...v1.3.1

### 1.3.0

* Add knapsack binary

    https://github.com/KnapsackPro/knapsack/pull/21

https://github.com/KnapsackPro/knapsack/compare/v1.2.1...v1.3.0

### 1.2.1

* Add support for Turnip features

    https://github.com/KnapsackPro/knapsack/pull/19

https://github.com/KnapsackPro/knapsack/compare/v1.2.0...v1.2.1

### 1.2.0

* Add minitest adapter.
* Fix bug with missing global time execution when tests took less than second.

https://github.com/KnapsackPro/knapsack/compare/v1.1.1...v1.2.0

### 1.1.1

* Use `system` instead of `exec` in rake tasks so we can return exit code from command.

https://github.com/KnapsackPro/knapsack/compare/v1.1.0...v1.1.1

### 1.1.0

* Add support for Buildkite.com ENV variables `BUILDKITE_PARALLEL_JOB_COUNT` and `BUILDKITE_PARALLEL_JOB`.

### 1.0.4

* Pull request #12 - Raise error when CI_NODE_INDEX >= CI_NODE_TOTAL

    https://github.com/KnapsackPro/knapsack/pull/12

### 1.0.3

* Fix bug #11 - Track properly time when using Timecop gem in tests.

    https://github.com/KnapsackPro/knapsack/issues/11

    https://github.com/KnapsackPro/knapsack/issues/9

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
