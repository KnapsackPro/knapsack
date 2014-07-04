# Knapsack

Parallel specs across CI server nodes based on each spec file's time execution.

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
        time_offset_warning: 30,
    })
    Knapsack::Adapters::Rspec.bind

Generate time execution report for your spec files.

    $ KNAPSACK_GENERATE_REPORT=true rspec spec

Commit generated report `knapsack_report.json` into your repository.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/knapsack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
