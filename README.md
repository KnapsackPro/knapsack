# Knapsack

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'knapsack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knapsack

## Usage

Add to your `spec_helper.rb`:

    require 'knapsack'
    Knapsack::Adapters::Rspec.bind

Run your specs with enabled tracker:

    $ KNAPSACK_TRACKER_ENABLED=true rspec spec

## Contributing

1. Fork it ( https://github.com/[my-github-username]/knapsack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
