module Knapsack
  module Adapters
    class BaseAdapter
      REPORT_PATH = 'knapsack_base_report.json'

      def self.bind
        adapter = new
        adapter.bind
        adapter
      end

      def bind
        set_report_path

        if tracker.config[:generate_report]
          Knapsack.logger.info 'Knapsack report generator started!'
          bind_time_tracker
          bind_report_generator
        elsif tracker.config[:enable_time_offset_warning]
          Knapsack.logger.info 'Knapsack time offset warning enabled!'
          bind_time_tracker
          bind_time_offset_warning
        else
          Knapsack.logger.warn 'Knapsack adapter is off!'
        end
      end

      def bind_time_tracker
        raise NotImplementedError
      end

      def bind_report_generator
        raise NotImplementedError
      end

      def bind_time_offset_warning
        raise NotImplementedError
      end

      private

      def tracker
        Knapsack.tracker
      end

      def set_report_path
        Knapsack.report.config({
          report_path: self.class::REPORT_PATH
        })
      end
    end
  end
end
