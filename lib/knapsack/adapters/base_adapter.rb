module Knapsack
  module Adapters
    class BaseAdapter
      # Just examples, please overwrite constants in subclasses
      TEST_DIR_PATTERN = 'test/**{,/*/**}/*_test.rb'
      REPORT_PATH = 'knapsack_base_report.json'

      def self.bind
        adapter = new
        adapter.bind
        adapter
      end

      def bind
        update_report_config

        if tracker.config[:generate_report]
          if tracker.config[:merge_report]
            Knapsack.logger.info 'Knapsack report generator started! Will merge results into existing json'
            bind_time_tracker
            bind_merge_report
          else
            Knapsack.logger.info 'Knapsack report generator started!'
            bind_time_tracker
            bind_report_generator
          end
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

      def bind_merge_report
        raise NotImplementedError
      end
      private

      def tracker
        Knapsack.tracker
      end

      def update_report_config
        current_test_file_pattern = Knapsack.report.config[:test_file_pattern]
        current_report_path = Knapsack.report.config[:report_path]

        Knapsack.report.config({
          test_file_pattern: Knapsack::Config::Env.test_file_pattern || current_test_file_pattern || self.class::TEST_DIR_PATTERN,
          report_path: Knapsack::Config::Env.report_path || current_report_path || self.class::REPORT_PATH
        })
      end
    end
  end
end
