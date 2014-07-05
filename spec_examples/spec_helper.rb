require 'knapsack'
Knapsack.tracker.config({
  enable_time_offset_warning: true,
  time_offset_in_seconds: 5
})
Knapsack.report.config({
  report_path: 'knapsack_report.json'
})
Knapsack::Adapters::Rspec.bind

RSpec.configure do |config|
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
