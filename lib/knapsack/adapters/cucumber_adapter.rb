module Knapsack
  module Adapters
    class CucumberAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'features/**{,/*/**}/*.feature'
      REPORT_PATH = 'knapsack_cucumber_report.json'

      def bind_time_tracker
        Around do |object, block|
          Knapsack.tracker.test_path = CucumberAdapter.test_path(object)
          Knapsack.tracker.start_timer
          block.call
          Knapsack.tracker.stop_timer
        end

        ::Kernel.at_exit do
          Knapsack.logger.info(Presenter.global_time)
        end
      end

      def bind_report_generator
        ::Kernel.at_exit do
          Knapsack.report.save
          Knapsack.logger.info(Presenter.report_details)
        end
      end

      def bind_time_offset_warning
        ::Kernel.at_exit do
          Knapsack.logger.warn(Presenter.time_offset_warning)
        end
      end

      def self.test_path(object)
        if Cucumber::VERSION.to_i >= 2
          test_case = object
          test_case.location.file
        else
          scenario_or_outline_table = object
          if scenario_or_outline_table.respond_to?(:file)
            scenario_or_outline_table.file
          else
            scenario_or_outline_table.scenario_outline.file
          end
        end
      end

      private

      def Around(*tag_expressions, &proc)
        ::Cucumber::RbSupport::RbDsl.register_rb_hook('around', tag_expressions, proc)
      end
    end
  end
end
