require 'spinach'

module Knapsack
  module Adapters
    class SpinachAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'features/**{,/*/**}/*.feature'
      REPORT_PATH = 'knapsack_spinach_report.json'

      def bind_time_tracker
        Spinach.hooks.before_scenario do |scenario_data, step_definitions|
          Knapsack.tracker.test_path = SpinachAdapter.test_path(scenario_data)
          Knapsack.tracker.start_timer
        end

        Spinach.hooks.after_scenario do
          Knapsack.tracker.stop_timer
        end

        Spinach.hooks.after_run do
          Knapsack.logger.info(Presenter.global_time)
        end
      end

      def bind_report_generator
        Spinach.hooks.after_run do
          Knapsack.report.save
          Knapsack.logger.info(Presenter.report_details)
        end
      end

      def bind_time_offset_warning
        Spinach.hooks.after_run do
          Knapsack.logger.log(
            Presenter.time_offset_log_level,
            Presenter.time_offset_warning
          )
        end
      end

      def self.test_path(scenario)
        scenario.feature.filename
      end
    end
  end
end
