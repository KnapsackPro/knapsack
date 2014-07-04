module Knapsack
  module Adapters
    class Rspec < Base
      protected

      def bind_time_tracker
        ::RSpec.configure do |config|
          config.before(:each) do
            Knapsack.tracker.spec_path = Rspec.spec_path
            Knapsack.tracker.start_timer
          end

          config.after(:each) do
            Knapsack.tracker.stop_timer
          end

          config.after(:suite) do
            puts Presenter.global_time
          end
        end
      end

      def bind_report_generator
        ::RSpec.configure do |config|
          config.after(:suite) do
            puts Presenter.report_yml
            puts Presenter.report_json
          end
        end
      end

      def self.spec_path
        ::RSpec.current_example.metadata[:example_group][:file_path]
      end
    end
  end
end
