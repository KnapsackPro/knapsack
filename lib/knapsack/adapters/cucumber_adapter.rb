module Knapsack
  module Adapters
    class CucumberAdapter < BaseAdapter
      def bind_time_tracker
        Around do |scenario, block|
          Knapsack.tracker.spec_path = scenario.file
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

      private

      def Around(*tag_expressions, &proc)
        ::Cucumber::RbSupport::RbDsl.register_rb_hook('around', tag_expressions, proc)
      end
    end
  end
end
