require 'minitest/autorun'

require 'knapsack'

Knapsack.tracker.config({
  enable_time_offset_warning: true,
  time_offset_in_seconds: 3
})
Knapsack.report.config({
  report_path: 'knapsack_minitest_report.json'
})

if ENV['CUSTOM_LOGGER']
  require 'logger'
  Knapsack.logger = Logger.new(STDOUT)
  Knapsack.logger.level = Logger::INFO
end

knapsack_adapter = Knapsack::Adapters::MinitestAdapter.bind
knapsack_adapter.set_test_helper_path(__FILE__)
