module Knapsack
  class Config
    class << self
      def report_path
        ENV['KNAPSACK_REPORT_PATH'] || 'knapsack_report.json'
      end

      def ci_node_total
        ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL'] || 1
      end

      def ci_node_index
        ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX'] || 0
      end

      def spec_pattern
        ENV['KNAPSACK_SPEC_PATTERN'] || 'spec/**/*_spec.rb'
      end

      def enable_time_offset_warning
        true
      end

      def time_offset_in_seconds
        30
      end

      def generate_report
        ENV['KNAPSACK_GENERATE_REPORT'] || false
      end
    end
  end
end
