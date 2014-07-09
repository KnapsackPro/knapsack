# Knapsack

[![Gem Version](https://badge.fury.io/rb/knapsack.png)][gem_version]
[![Build Status](https://travis-ci.org/ArturT/knapsack.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/ArturT/knapsack.png)][codeclimate]
[![Coverage Status](https://codeclimate.com/github/ArturT/knapsack/coverage.png)][coverage]

[gem_version]: https://rubygems.org/gems/knapsack
[travis]: http://travis-ci.org/ArturT/knapsack
[codeclimate]: https://codeclimate.com/github/ArturT/knapsack
[coverage]: https://codeclimate.com/github/ArturT/knapsack

Parallel specs across CI server nodes based on each spec file's time execution.

**Work in progress, gem is not ready yet!**

## Installation

Add this line to your application's Gemfile:

    gem 'knapsack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knapsack

## Usage

Add at the beginning of your `spec_helper.rb`:

    require 'knapsack'

    # default configuration, you can change it or omit
    Knapsack.tracker.config({
        enable_time_offset_warning: true,
        time_offset_in_seconds: 30
    })

    # default configuration for report
    Knapsack.report.config({
      report_path: 'knapsack_report.json'
    })

    Knapsack::Adapters::RspecAdapter.bind

Generate time execution report for your spec files.

    $ KNAPSACK_GENERATE_REPORT=true rspec spec

Commit generated report `knapsack_report.json` into your repository.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/knapsack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Tests

### Spec

To run specs for Knapsack gem type:

    $ rspec spec

### Spec examples

Directory `spec_examples` contains examples of fast and slow specs. There is a `spec_example/spec_helper.rb` with binded Knapsack.

Change one spec to make it sure it will take more than 5 seconds then run below to see Knapsack time offset warning.

    $ rspec --default-path spec_examples

To generate a new knapsack report file please type:

    $ KNAPSACK_GENERATE_REPORT=true rspec --default-path spec_examples

**Warning:** Current `knapsack_report.json` file was generated for `spec_examples` except `spec_examples/leftover` directory. Just for testing reason to see how leftover specs will be distribute across CI nodes.

To see specs distributed for the first CI node type:

    $ CI_NODE_TOTAL=2 CI_NODE_INDEX=0 KNAPSACK_SPEC_PATTERN="spec_examples/**/*_spec.rb" bundle exec rake knapsack:rspec
