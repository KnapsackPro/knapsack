[Knapsack, The K is silent](http://www.youtube.com/watch?v=-Ae590hensE)

# ![Knapsack logo](docs/images/logos/knapsack-logo-@2.png)

[![Gem Version](https://badge.fury.io/rb/knapsack.png)][gem_version]
[![Build Status](https://travis-ci.org/ArturT/knapsack.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/ArturT/knapsack.png)][codeclimate]
[![Coverage Status](https://codeclimate.com/github/ArturT/knapsack/coverage.png)][coverage]

[gem_version]: https://rubygems.org/gems/knapsack
[travis]: http://travis-ci.org/ArturT/knapsack
[codeclimate]: https://codeclimate.com/github/ArturT/knapsack
[coverage]: https://codeclimate.com/github/ArturT/knapsack

**Knapsack splits tests across CI nodes and makes sure that tests will run comparable time on each node.**

Parallel tests across CI server nodes based on each test file's time execution. Knapsack generates a test time execution report and uses it for future test runs.

The knapsack gem supports:

* [RSpec](http://rspec.info)
* [Cucumber](https://cucumber.io)
* [Minitest](http://docs.seattlerb.org/minitest/)
* [Spinach](https://github.com/codegram/spinach)
* [Turnip](https://github.com/jnicklas/turnip)

### Without Knapsack

![Without Knapsack gem](docs/images/without_knapsack.png)

### With Knapsack

![With Knapsack gem](docs/images/with_knapsack.png)

### Features

| Feature | knapsack gem | knapsack_pro gem
| --- | :---: | :---:
| Test suite split based on tests time execution | ✔ | ✔
| Automated tests time execution recording | ✘ | ✔
| Test suite split based on most up to date tests time execution data | ✘ | ✔
| [Show all features](https://knapsackpro.com/features?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=show_all_features) | |

**Would you like to try [knapsack_pro gem](https://github.com/KnapsackPro/knapsack_pro-ruby) with more features and free access for early users? Please [visit Knapsack Pro](http://knapsackpro.com?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=try_knapsack_pro).**

### Presentations about knapsack gem

* [X 2014 Kraków Ruby User Group](http://slides.com/arturt/parallel-tests-in-comparable-time)
* [VII 2014 Lunar Logic Dev Meeting](http://slides.com/arturt/knapsack)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Update gem](#update-gem)
- [Installation](#installation)
- [Usage](#usage)
  - [Step for RSpec](#step-for-rspec)
  - [Step for Cucumber](#step-for-cucumber)
  - [Step for Minitest](#step-for-minitest)
  - [Step for Spinach](#step-for-spinach)
  - [Custom configuration](#custom-configuration)
  - [Common step](#common-step)
    - [Adding or removing tests](#adding-or-removing-tests)
- [Setup your CI server](#setup-your-ci-server)
  - [Info about ENV variables](#info-about-env-variables)
  - [Passing arguments to rake task](#passing-arguments-to-rake-task)
    - [Passing arguments to rspec](#passing-arguments-to-rspec)
    - [Passing arguments to cucumber](#passing-arguments-to-cucumber)
    - [Passing arguments to minitest](#passing-arguments-to-minitest)
    - [Passing arguments to spinach](#passing-arguments-to-spinach)
  - [Knapsack binary](#knapsack-binary)
  - [Info for CircleCI users](#info-for-circleci-users)
    - [Step 1](#step-1)
    - [Step 2](#step-2)
  - [Info for Travis users](#info-for-travis-users)
    - [Step 1](#step-1-1)
    - [Step 2](#step-2-1)
  - [Info for semaphoreapp.com users](#info-for-semaphoreappcom-users)
    - [Step 1](#step-1-2)
    - [Step 2](#step-2-2)
  - [Info for buildkite.com users](#info-for-buildkitecom-users)
    - [Step 1](#step-1-3)
    - [Step 2](#step-2-3)
  - [Info for snap-ci.com users](#info-for-snap-cicom-users)
    - [Step 1](#step-1-4)
    - [Step 2](#step-2-4)
- [FAQ](#faq)
  - [What time offset warning means?](#what-time-offset-warning-means)
  - [How to generate knapsack report?](#how-to-generate-knapsack-report)
  - [What does "leftover specs" mean?](#what-does-leftover-specs-mean)
  - [How can I run tests from multiple directories?](#how-can-i-run-tests-from-multiple-directories)
  - [How to update existing knapsack report for a few test files?](#how-to-update-existing-knapsack-report-for-a-few-test-files)
  - [How to run tests for particular CI node in your development environment](#how-to-run-tests-for-particular-ci-node-in-your-development-environment)
- [Gem tests](#gem-tests)
  - [Spec](#spec)
  - [Spec examples](#spec-examples)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
- [Mentions](#mentions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Update gem

Please check [changelog](CHANGELOG.md) before update gem. Knapsack follows [semantic versioning](http://semver.org).

## Installation

Add those lines to your application's Gemfile:

```ruby
group :test, :development do
  gem 'knapsack'
end
```

And then execute:

    $ bundle

Add this line at the bottom of `Rakefile`:

```ruby
Knapsack.load_tasks if defined?(Knapsack)
```

## Usage

You can find here example of rails app with already configured knapsack.

https://github.com/KnapsackPro/rails-app-with-knapsack

### Step for RSpec

Add at the beginning of your `spec_helper.rb`:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

Knapsack::Adapters::RSpecAdapter.bind
```

### Step for Cucumber

Create file `features/support/knapsack.rb` and add there:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

Knapsack::Adapters::CucumberAdapter.bind
```

### Step for Minitest

Add at the beginning of your `test_helper.rb`:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

knapsack_adapter = Knapsack::Adapters::MinitestAdapter.bind
knapsack_adapter.set_test_helper_path(__FILE__)
```

### Step for Spinach

Create file `features/support/env.rb` and add there:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

Knapsack::Adapters::SpinachAdapter.bind
```

### Custom configuration

You can change default Knapsack configuration for RSpec, Cucumber, Minitest or Spinach tests. Here are examples what you can do. Put below configuration instead of `CUSTOM_CONFIG_GOES_HERE`.

```ruby
Knapsack.tracker.config({
  enable_time_offset_warning: true,
  time_offset_in_seconds: 30
})

Knapsack.report.config({
  test_file_pattern: 'spec/**{,/*/**}/*_spec.rb', # default value based on adapter
  report_path: 'knapsack_custom_report.json'
})

# you can use your own logger
require 'logger'
Knapsack.logger = Logger.new(STDOUT)
Knapsack.logger.level = Logger::INFO
```

### Common step

Generate time execution report for your test files. Run below command on one of your CI nodes.

    # Step for RSpec
    $ KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    $ KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

    # Step for Minitest
    $ KNAPSACK_GENERATE_REPORT=true bundle exec rake test
    # If you use rails 5 then run this instead:
    $ KNAPSACK_GENERATE_REPORT=true bundle exec rake knapsack:minitest

    # Step for Spinach
    $ KNAPSACK_GENERATE_REPORT=true bundle exec spinach

Commit generated report `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` into your repository.

This report should be updated only after you add a lot of new slow tests or you change existing ones which causes a big time execution difference between CI nodes. Either way, you will get time offset warning at the end of the rspec/cucumber/minitest results which reminds you when it’s a good time to regenerate the knapsack report.

`KNAPSACK_GENERATE_REPORT` is truthy when `"true"` or `0`.  All other values are falsy, though
[`"false"`, and `1` are semantically
preferrable](https://en.wikipedia.org/wiki/True_and_false_(commands)).

#### Adding or removing tests

There is no need to regenerate the report every time when you add/remove test file. If you remove a test file then Knapsack will ignore its entry in report. In case when you add a new file and it doesn't already exist in report, the test file will be assigned to one of the CI node.

You'll want to regenerate your execution report whenever you remove or add a test file with a long time execution  time that would affect one of the CI nodes. You will get Knapsack notification whenever is good time to regenerate report.

## Setup your CI server

On your CI server run this command for the first CI node. Update `CI_NODE_INDEX` for the next one.

    # Step for RSpec
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

    # Step for Minitest
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:minitest

    # Step for Spinach
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:spinach

You can add `KNAPSACK_TEST_FILE_PATTERN` if your tests are not in default directory. For instance:

    # Step for RSpec
    $ KNAPSACK_TEST_FILE_PATTERN="directory_with_specs/**{,/*/**}/*_spec.rb" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ KNAPSACK_TEST_FILE_PATTERN="directory_with_features/**/*.feature" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

    # Step for Minitest
    $ KNAPSACK_TEST_FILE_PATTERN="directory_with_tests/**{,/*/**}/*_spec.rb" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:minitest

    # Step for Spinach
    $ KNAPSACK_TEST_FILE_PATTERN="directory_with_features/**/*.feature" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:spinach

You can set `KNAPSACK_REPORT_PATH` if your knapsack report was saved in non default location. Example:

    # Step for RSpec
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

    # Step for Minitest
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:minitest

    # Step for Spinach
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:spinach

### Info about ENV variables

`CI_NODE_TOTAL` - total number CI nodes you have.

`CI_NODE_INDEX` - index of current CI node starts from 0. Second CI node should have `CI_NODE_INDEX=1`.

### Passing arguments to rake task

#### Passing arguments to rspec

Knapsack allows you to pass arguments through to rspec. For example if you want to run only specs that have the tag `focus`. If you do this with rspec directly it would look like:

    $ bundle exec rake rspec --tag focus

To do this with Knapsack you simply add your rspec arguments as parameters to the knapsack rake task.

    $ bundle exec rake "knapsack:rspec[--tag focus]"

Remember that using tags to limit which specs get run will affect the time each file takes to run. One solution to this is to generate a new `knapsack_rspec_report.json` for the commonly run scenarios.

#### Passing arguments to cucumber

Add arguments to knapsack cucumber task like this:

    $ bundle exec rake "knapsack:cucumber[--name feature]"

#### Passing arguments to minitest

Add arguments to knapsack minitest task like this:

    $ bundle exec rake "knapsack:minitest[--arg_name value]"

For instance to run verbose tests:

    $ bundle exec rake "knapsack:minitest[--verbose]"

#### Passing arguments to spinach

Add arguments to knapsack spinach task like this:

    $ bundle exec rake "knapsack:spinach[--name feature]"
    
### Knapsack binary

You can install knapsack globally and use binary. For instance:

    $ knapsack rspec "--tag custom_tag_name --profile"
    $ knapsack cucumber
    $ knapsack minitest "--verbose --pride"
    $ knapsack spinach "-f spinach_examples"

[Here](https://github.com/ArturT/knapsack/pull/21) you will find example when it might be useful.

### Info for CircleCI users

If you are using circleci.com you can omit `CI_NODE_TOTAL` and `CI_NODE_INDEX`. Knapsack will use `CIRCLE_NODE_TOTAL` and `CIRCLE_NODE_INDEX` provided by CircleCI.

Here is an example for test configuration in your `circleci.yml` file.

#### Step 1

For the first time run all tests on a single CI node with enabled report generator.

```yaml
test:
  override:
    # Step for RSpec
    - KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    - KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

    # Step for Minitest
    - KNAPSACK_GENERATE_REPORT=true bundle exec rake test

    # Step for Spinach
    - KNAPSACK_GENERATE_REPORT=true bundle exec spinach
```

After tests pass on your CircleCI machine your should copy knapsack json report which is rendered at the end of rspec/cucumber/minitest results. Save it into your repository as `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` file and commit.

#### Step 2

Now you should update test command and enable parallel. Please remember to add additional containers for your project in CircleCI settings.

```yaml
test:
  override:
    # Step for RSpec
    - bundle exec rake knapsack:rspec:
        parallel: true # Caution: there are 8 spaces indentation!

    # Step for Cucumber
    - bundle exec rake knapsack:cucumber:
        parallel: true # Caution: there are 8 spaces indentation!

    # Step for Minitest
    - bundle exec rake knapsack:minitest:
        parallel: true # Caution: there are 8 spaces indentation!

    # Step for Spinach
    - bundle exec rake knapsack:spinach:
        parallel: true # Caution: there are 8 spaces indentation!
```

Now everything should works. You will get warning at the end of rspec/cucumber/minitest results if time execution will take too much.

### Info for Travis users

#### Step 1

For the first time run all tests at once with enabled report generator. Edit `.travis.yml`

```yaml
script:
  # Step for RSpec
  - "KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec"

  # Step for Cucumber
  - "KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features"

  # Step for Minitest
  - "KNAPSACK_GENERATE_REPORT=true bundle exec rake test"

  # Step for Spinach
  - "KNAPSACK_GENERATE_REPORT=true bundle exec spinach"
```

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber/minitest results. Save it into your repository as `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` file and commit.

#### Step 2

You can parallel your builds across virtual machines with [travis matrix feature](http://docs.travis-ci.com/user/speeding-up-the-build/#Parallelizing-your-builds-across-virtual-machines). Edit `.travis.yml`

```yaml
script:
  # Step for RSpec
  - "bundle exec rake knapsack:rspec"

  # Step for Cucumber
  - "bundle exec rake knapsack:cucumber"

  # Step for Minitest
  - "bundle exec rake knapsack:minitest"

  # Step for Spinach
  - "bundle exec rake knapsack:spinach"

env:
  - CI_NODE_TOTAL=2 CI_NODE_INDEX=0
  - CI_NODE_TOTAL=2 CI_NODE_INDEX=1
```

If you want to have some global ENVs and matrix of ENVs then do it like this:

```yaml
script:
  # Step for RSpec
  - "bundle exec rake knapsack:rspec"

  # Step for Cucumber
  - "bundle exec rake knapsack:cucumber"

  # Step for Minitest
  - "bundle exec rake knapsack:minitest"

  # Step for Spinach
  - "bundle exec rake knapsack:spinach"

env:
  global:
    - RAILS_ENV=test
    - MY_GLOBAL_VAR=123
    - CI_NODE_TOTAL=2
  matrix:
    - CI_NODE_INDEX=0
    - CI_NODE_INDEX=1
```

Such configuration will generate matrix with 2 following ENV rows:

    CI_NODE_TOTAL=2 CI_NODE_INDEX=0 RAILS_ENV=test MY_GLOBAL_VAR=123
    CI_NODE_TOTAL=2 CI_NODE_INDEX=1 RAILS_ENV=test MY_GLOBAL_VAR=123

More info about global and matrix ENV configuration in [travis docs](http://docs.travis-ci.com/user/build-configuration/#Environment-variables).

### Info for semaphoreapp.com users

#### Step 1

For the first time run all tests at once with enabled report generator. Set up your build command:

    # Step for RSpec
    KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

    # Step for Minitest
    KNAPSACK_GENERATE_REPORT=true bundle exec rake test

    # Step for Spinach
    KNAPSACK_GENERATE_REPORT=true bundle exec spinach

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber/test results. Save it into your repository as `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` file and commit.

#### Step 2

Knapsack supports semaphoreapp ENVs `SEMAPHORE_THREAD_COUNT` and `SEMAPHORE_CURRENT_THREAD`. The only thing you need to do is set up knapsack rspec/cucumber/minitest command for as many threads as you need. Here is an example:

    # Thread 1
    ## Step for RSpec
    bundle exec rake knapsack:rspec
    ## Step for Cucumber
    bundle exec rake knapsack:cucumber
    ## Step for Minitest
    bundle exec rake knapsack:minitest
    ## Step for Spinach
    bundle exec rake knapsack:spinach

    # Thread 2
    ## Step for RSpec
    bundle exec rake knapsack:rspec
    ## Step for Cucumber
    bundle exec rake knapsack:cucumber
    ## Step for Minitest
    bundle exec rake knapsack:minitest
    ## Step for Spinach
    bundle exec rake knapsack:spinach

Tests will be split across threads.

### Info for buildkite.com users

#### Step 1

For the first time run all tests at once with enabled report generator. Run the following commands locally:

    # Step for RSpec
    KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

    # Step for Minitest
    KNAPSACK_GENERATE_REPORT=true bundle exec rake test

    # Step for Spinach
    KNAPSACK_GENERATE_REPORT=true bundle exec spinach

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber/minitest results. Save it into your repository as `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` file and commit.

#### Step 2

Knapsack supports buildkite ENVs `BUILDKITE_PARALLEL_JOB_COUNT` and `BUILDKITE_PARALLEL_JOB`. The only thing you need to do is to configure the parallelism parameter in your build step and run the appropiate command in your build

    # Step for RSpec
    bundle exec rake knapsack:rspec

    # Step for Cucumber
    bundle exec rake knapsack:cucumber

    # Step for Minitest
    bundle exec rake knapsack:minitest

    # Step for Spinach
    bundle exec rake knapsack:spinach

### Info for snap-ci.com users

#### Step 1

For the first time run all tests at once with enabled report generator. Run the following commands locally:

    # Step for RSpec
    KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

    # Step for Minitest
    KNAPSACK_GENERATE_REPORT=true bundle exec rake test

    # Step for Spinach
    KNAPSACK_GENERATE_REPORT=true bundle exec spinach

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber/minitest results. Save it into your repository as `knapsack_rspec_report.json`, `knapsack_cucumber_report.json`, `knapsack_minitest_report.json` or `knapsack_spinach_report.json` file and commit.

#### Step 2

Knapsack supports snap-ci.com ENVs `SNAP_WORKER_TOTAL` and `SNAP_WORKER_INDEX`. The only thing you need to do is to configure number of workers for your project in configuration settings in order to enable parallelism. Next thing is to set below commands to be executed in your stage:

    # Step for RSpec
    bundle exec rake knapsack:rspec

    # Step for Cucumber
    bundle exec rake knapsack:cucumber

    # Step for Minitest
    bundle exec rake knapsack:minitest

    # Step for Spinach
    bundle exec rake knapsack:spinach

## FAQ

### What time offset warning means?

At the end of tests execution results you can see warning like this:

```
========= Knapsack Time Offset Warning ==========
Time offset: 30s
Max allowed node time execution: 02m 30s
Exceeded time: 37s
```

`Time offset: 30s` - this is the current time offset value, by default it’s 30s. Let’s assume whole test suite takes 4 minutes and you do split across 2 CI nodes so the optimal split is 2 minutes per node. Time offset 30s means when tests on single CI node will take longer than 2 minutes and 30s then you see warning about regenerating report because probably test suite files changed and the knapsack report contains old time execution data about each test file so regenerating knapsack report should help you provide a more optimal test suite split.

`Max allowed node time execution: 02m 30s` - it’s average time execution of tests per CI node + time offset. In this case average tests time execution per CI node is 2 minutes.

`Exceeded time: 37s` - it means tests on particular CI node took 37s longer than `max allowed node time execution`. Sometimes this value is negative when tests executed faster than `max allowed node time execution`.

### How to generate knapsack report?

If you want to regenerate report take a look [here](#common-step).

`KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec`

If you run command like this on your development machine then test suite time execution might be different than if you generate a report on CI machine (for instance tests might be faster on your machine then on CI node) so that might be a reason why you see warning about regenerating report. You can generate the report on single CI node which should give you result specific for your CI node instead of your development machine. In case you don't want to bother about manually regenerating knapsack report please take a look on [knapsack_pro gem](http://knapsackpro.com?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=no_manual_report).

### What does "leftover specs" mean?

When you run your specs with knapsack rake task then you will see in the output something like:

```
Report specs:
spec/models/user_spec.rb
spec/controllers/users_controller_spec.rb

Leftover specs:
spec/models/book_spec.rb
spec/models/author_spec.rb
```

The leftover specs mean we don't have recorded time execution for those test files so the leftover specs were distributed across CI nodes based on file name instead.
The reason might be that someone added a new test file after knapsack report was generated. Another reason might be an empty spec file.
If you have a lot of leftover specs then you can [generate knapsack report again](#how-to-generate-knapsack-report) to improve you test distribution across CI nodes.

### How can I run tests from multiple directories?

The test file pattern config option supports any glob pattern handled by [`Dir.glob`](http://ruby-doc.org/core-2.2.0/Dir.html#method-c-glob) and can be configured to pull test files from multiple directories. An example of this when using RSpec would be `"{spec,engines/**/spec}/**{,/*/**}/*_spec.rb"`. For complex cases like this, the test directory can't be extracted and must be specified manually using the `KNAPSACK_TEST_DIR` environment variable:

    $ KNAPSACK_TEST_DIR=spec KNAPSACK_TEST_FILE_PATTERN="{spec,engines/**/spec}/**{,/*/**}/*_spec.rb" bundle exec rake knapsack:rspec

`KNAPSACK_TEST_DIR` will be your default path for rspec so you should put there your `spec_helper.rb`. Please ensure you will require it in your test files this way:

```ruby
# good
require_relative 'spec_helper'

# bad - won't work
require 'spec_helper'
```

### How to update existing knapsack report for a few test files?

You may want to look at monkey patch in [this issue](https://github.com/ArturT/knapsack/issues/34). Take into account that there are some cons of this approach.

### How to run tests for particular CI node in your development environment

In your development environment you can debug tests that were run on the particular CI node.
For instance to run subset of tests for the first CI node with specified seed you can do.

    CI_NODE_TOTAL=2 \
    CI_NODE_INDEX=0 \
    bundle exec rake "knapsack:rspec[--seed 123]"

Above example is for RSpec. You can use respectively rake task name and token environment variable when you want to run tests for minitest, cucumber or spinach.

### How can I change log level?

You can change log level by specifying the `KNAPSACK_LOG_LEVEL` environment variable.

    KNAPSACK_LOG_LEVEL=warn bundle exec rake knapsack:rspec
    
Available values are `debug`, `info`, and `warn`. The default log level is `info`.

## Gem tests

### Spec

To run specs for Knapsack gem type:

    $ bundle exec rspec spec

### Spec examples

Directory `spec_examples` contains examples of fast and slow specs. There is a `spec_example/spec_helper.rb` with binded Knapsack.

To generate a new knapsack report for specs with `focus` tag (only specs in `spec_examples/leftover` directory have no `focus` tag), please type:

    $ KNAPSACK_GENERATE_REPORT=true bundle exec rspec --default-path spec_examples --tag focus

**Warning:** Current `knapsack_rspec_report.json` file was generated for `spec_examples` except `spec_examples/leftover` directory. Just for testing reason to see how leftover specs will be distribute in a dumb way across CI nodes.

To see specs distributed for the first CI node type:

    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 KNAPSACK_SPEC_PATTERN="spec_examples/**{,/*/**}/*_spec.rb" bundle exec rake knapsack:rspec

Specs in `spec_examples/leftover` take more than 3 seconds. This should cause a Knapsack time offset warning because we set `time_offset_in_seconds` to 3 in `spec_examples/spec_helper.rb`. Type below to see warning:

    $ bundle exec rspec --default-path spec_examples

## Contributing

1. Fork it ( https://github.com/ArturT/knapsack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. You can create example tests in related repository with example of [rails application and knapsack gem usage](https://github.com/KnapsackPro/rails-app-with-knapsack).
6. Create a new Pull Request

## Acknowledgements

Many thanks to [Małgorzata Nowak](https://github.com/informatykgosia) for beautiful logo.

## Mentions

* Lunar Logic Blog | [Parallel your specs and don’t waste time](http://blog.lunarlogic.io/2014/parallel-your-specs-and-dont-waste-time/)
* Travis CI | [Parallelizing RSpec and Cucumber on multiple VMs](http://docs.travis-ci.com/user/speeding-up-the-build/#Parallelizing-RSpec-and-Cucumber-on-multiple-VMs)
* Semaphore | [Running RSpec specs in parallel](https://semaphoreapp.com/docs/running-rspec-specs-in-threads.html)
* Semaphore | [Running Cucumber scenarios in parallel](https://semaphoreapp.com/docs/running-cucumber-scenarios-in-threads.html)
* Buildkite | [Libraries](https://buildkite.com/docs/guides/parallelizing-builds#libraries)
* Snap CI | [Knapsack: optimal test suite split based on time execution](https://docs.snap-ci.com/speeding-up-builds/test-parallelism/#parallelism-using-third-party-tools%23knapsack-optimal-test-suite-split-based-on-time-execution)
