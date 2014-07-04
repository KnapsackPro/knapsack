require 'knapsack'
require 'timecop'
require 'codeclimate-test-reporter'

Timecop.safe_mode = true

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
