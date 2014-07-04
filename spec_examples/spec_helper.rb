require 'knapsack'
Knapsack.tracker.config({
  enable_time_offset_warning: true,
  time_offset_warning: 5
})
Knapsack::Adapters::Rspec.bind

RSpec.configure do |config|
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
