module Knapsack
  module RSpec
    class Adapter
      class << self
        def bind
          ::RSpec.configure do |config|
            config.before(:each) do
              Knapsack.tracker.spec_path = Adapter.spec_path
              Knapsack.tracker.start_timer
            end

            config.after(:each) do
              Knapsack.tracker.stop_timer
            end

            config.after(:suite) do
              puts Presenter.global_time
              puts Presenter.report_yml
              puts Presenter.report_json
            end
          end
        end

        def spec_path
          ::RSpec.current_example.metadata[:example_group][:file_path]
        end
      end
    end
  end
end
