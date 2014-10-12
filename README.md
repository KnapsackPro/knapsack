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

Parallel specs across CI server nodes based on each spec file's time execution. Knapsack generates a spec time execution report and uses it for future test runs.

Short [presentation](http://slides.com/arturt/knapsack) about gem.

**[Sign up](http://knapsack.launchrock.com) to get info about launch Knapsack Pro with more features and free access for beta users.**

### Without Knapsack

![Without Knapsack gem](docs/images/without_knapsack.png)

### With Knapsack

![With Knapsack gem](docs/images/with_knapsack.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'knapsack'
```

And then execute:

    $ bundle

## Usage

### Step for RSpec

Add at the beginning of your `spec_helper.rb`:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

Knapsack::Adapters::RspecAdapter.bind
```

### Step for Cucumber

Create file `features/support/knapsack.rb` and add there:

```ruby
require 'knapsack'

# CUSTOM_CONFIG_GOES_HERE

Knapsack::Adapters::CucumberAdapter.bind
```

### Custom configuration

You can change default Knapsack configuration for RSpec or Cucumber tests. Here are examples what you can do. Put below configuration instead of `CUSTOM_CONFIG_GOES_HERE`.

```ruby
Knapsack.tracker.config({
  enable_time_offset_warning: true,
  time_offset_in_seconds: 30
})

Knapsack.report.config({
  report_path: 'knapsack_custom_report.json'
})

# you can use your own logger
require 'logger'
Knapsack.logger = Logger.new(STDOUT)
Knapsack.logger.level = Logger::INFO
```

### Common step

Add in your `Rakefile` this lines:

```ruby
require 'knapsack'
Knapsack.load_tasks
```

Generate time execution report for your test files. Run below command on one of your CI nodes.

    # Step for RSpec
    $ KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    $ KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

Commit generated report `knapsack_rspec_report.json` or `knapsack_cucumber_report.json` into your repository.

This report should be updated only after you add a lot of new slow tests or you change existing ones which causes a big time execution difference between CI nodes. Either way, you will get time offset warning at the end of the rspec results which reminds you when it’s a good time to regenerate the knapsack report.

## Setup your CI server

On your CI server run this command for the first CI node. Update `CI_NODE_INDEX` for the next one.

    # Step for RSpec
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

You can add `KNAPSACK_SPEC_PATTERN` if your specs are not in `spec` directory. For instance:

    # Step for RSpec
    $ KNAPSACK_SPEC_PATTERN="directory_with_specs/**/*_spec.rb" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ KNAPSACK_SPEC_PATTERN="directory_with_features/**/*.feature" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

You can set `KNAPSACK_REPORT_PATH` if your knapsack report was saved in non default location. Example:

    # Step for RSpec
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:rspec

    # Step for Cucumber
    $ KNAPSACK_REPORT_PATH="knapsack_custom_report.json" CI_NODE_TOTAL=2 CI_NODE_INDEX=0 bundle exec rake knapsack:cucumber

### Info about ENV variables

`CI_NODE_TOTAL` - total number CI nodes you have.

`CI_NODE_INDEX` - index of current CI node starts from 0. Second CI node should have `CI_NODE_INDEX=1`.

### Info for CircleCI users

If you are using circleci.com you can omit `CI_NODE_TOTAL` and `CI_NODE_INDEX`. Knapsack will use `CIRCLE_NODE_TOTAL` and `CIRCLE_NODE_INDEX` provided by CircleCI.

Here is an example for test configuration in your `circleci.yml` file.

#### Step 1

For the first time run all specs on a single CI node with enabled report generator.

```yaml
test:
  override:
    # Step for RSpec
    - KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    - KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features
```

After tests pass on your CircleCI machine your should copy knapsack json report which is rendered at the end of rspec/cucumber results. Save it into your repository as `knapsack_rspec_report.json` or `knapsack_cucumber_report.json` file and commit.

#### Step 2

Now you should update test command and enable parallel. Please remember to add additional containers for your project in CircleCI settings.

```yaml
test:
  override:
    # Step for RSpec
    - bundle exec rake knapsack:rspec:
        parallel: true

    # Step for Cucumber
    - bundle exec rake knapsack:cucumber:
        parallel: true
```

Now everything should works. You will get warning at the end of rspec/cucumber results if time execution will take too much.

### Info for Travis users

#### Step 1

For the first time run all specs at once with enabled report generator. Edit `.travis.yml`

```yaml
# Step for RSpec
script: "KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec"

# Step for Cucumber
script: "KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features"
```

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber results. Save it into your repository as `knapsack_rspec_report.json` or `knapsack_cucumber_report.json` file and commit.

#### Step 2

You can parallel your builds across virtual machines with [travis matrix feature](http://docs.travis-ci.com/user/speeding-up-the-build/#Parallelizing-your-builds-across-virtual-machines). Edit `.travis.yml`

```yaml
# Step for RSpec
script: "bundle exec rake knapsack:rspec"

# Step for Cucumber
script: "bundle exec rake knapsack:cucumber"

env:
  - CI_NODE_TOTAL=2 CI_NODE_INDEX=0
  - CI_NODE_TOTAL=2 CI_NODE_INDEX=1
```

If you want to have some global ENVs and matrix of ENVs then do it like this:

```yaml
# Step for RSpec
script: "bundle exec rake knapsack:rspec"

# Step for Cucumber
script: "bundle exec rake knapsack:cucumber"

env:
  global:
    - RAILS_ENV=test
    - MY_GLOBAL_VAR=123
  matrix:
    - CI_NODE_TOTAL=2 CI_NODE_INDEX=0
    - CI_NODE_TOTAL=2 CI_NODE_INDEX=1
```

Such configuration will generate matrix with 2 following ENV rows:

    CI_NODE_TOTAL=2 CI_NODE_INDEX=0 RAILS_ENV=test MY_GLOBAL_VAR=123
    CI_NODE_TOTAL=2 CI_NODE_INDEX=1 RAILS_ENV=test MY_GLOBAL_VAR=123

More info about global and matrix ENV configuration in [travis docs](http://docs.travis-ci.com/user/build-configuration/#Environment-variables).

### Info for semaphoreapp.com users

#### Step 1

For the first time run all specs at once with enabled report generator. Set up your build command:

    # Step for RSpec
    KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec

    # Step for Cucumber
    KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features

After tests pass your should copy knapsack json report which is rendered at the end of rspec/cucumber results. Save it into your repository as `knapsack_rspec_report.json` or `knapsack_cucumber_report.json` file and commit.

#### Step 2

Knapsack supports semaphoreapp ENVs `SEMAPHORE_THREAD_COUNT` and `SEMAPHORE_CURRENT_THREAD`. The only thing you need to do is set up knapsack rspec/cucumber command for as many threads as you need. Here is an example:

    # Thread 1
    ## Step for RSpec
    bundle exec rake knapsack:rspec
    ## Step for Cucumber
    bundle exec rake knapsack:cucumber

    # Thread 2
    ## Step for RSpec
    bundle exec rake knapsack:rspec
    ## Step for Cucumber
    bundle exec rake knapsack:cucumber

Tests will be split across threads.

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

    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 KNAPSACK_SPEC_PATTERN="spec_examples/**/*_spec.rb" bundle exec rake knapsack:rspec

Specs in `spec_examples/leftover` take more than 3 seconds. This should cause a Knapsack time offset warning because we set `time_offset_in_seconds` to 3 in `spec_examples/spec_helper.rb`. Type below to see warning:

    $ bundle exec rspec --default-path spec_examples

## Contributing

1. Fork it ( https://github.com/ArturT/knapsack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Acknowledgements

Many thanks to [Małgorzata Nowak](https://github.com/informatykgosia) for beautiful logo.

## Mentions

* Lunar Logic Blog | [Parallel your specs and don’t waste time](http://blog.lunarlogic.io/2014/parallel-your-specs-and-dont-waste-time/)
* Travis CI | [Parallelizing RSpec tests on multiple VMs](http://docs.travis-ci.com/user/speeding-up-the-build/#Parallelizing-RSpec-tests-on-multiple-VMs)
* Semaphore | [Running RSpec specs in parallel](https://semaphoreapp.com/docs/running-rspec-specs-in-threads.html)
