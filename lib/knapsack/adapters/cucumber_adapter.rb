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
          Knapsack.logger.log(
            Presenter.time_offset_log_level,
            Presenter.time_offset_warning
          )
        end
      end

      def self.test_path(object)
        if Cucumber::VERSION.to_i >= 2
          test_case = object
          test_case.location.file
        else
          if object.respond_to?(:scenario_outline)
            if object.scenario_outline.respond_to?(:feature)
              # Cucumber < 1.3
              object.scenario_outline.feature.file
            else
              # Cucumber >= 1.3
              object.scenario_outline.file
            end
          else
            if object.respond_to?(:feature)
              # Cucumber < 1.3
              object.feature.file
            else
              # Cucumber >= 1.3
              object.file
            end
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
