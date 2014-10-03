require 'timecop'
Timecop.safe_mode = true

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'knapsack'

Dir["#{Knapsack.root}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    if RSpec.current_example.metadata[:clear_tmp]
      FileUtils.mkdir_p(File.join(Knapsack.root, 'tmp'))
    end
  end

  config.after(:each) do
    if RSpec.current_example.metadata[:clear_tmp]
      FileUtils.rm_r(File.join(Knapsack.root, 'tmp'))
    end
  end
end
