require 'timecop'
Timecop.safe_mode = true

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'knapsack'

RSpec.configure do |config|
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
