module Knapsack
  module Adapters
    class SpinachAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'features/**{,/*/**}/*.feature'
      REPORT_PATH = 'knapsack_spinach_report.json'

      def bind_time_tracker
        Spinach.hooks.before_scenario do |scenario_data, step_definitions|
          Knapsack.tracker.test_path = scenario_data.feature.filename
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
          Knapsack.logger.warn(Presenter.time_offset_warning)
        end
      end

      def self.test_path(example_group)
        unless example_group[:turnip]
          until example_group[:parent_example_group].nil?
            example_group = example_group[:parent_example_group]
          end
        end

        example_group[:file_path]
      end
    end
  end
end
