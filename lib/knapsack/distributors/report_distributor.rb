module Knapsack
  module Distributors
    class ReportDistributor < BaseDistributor
      def sorted_report
        @sorted_report ||= report.sort_by { |test_path, time| time }.reverse
      end

      def sorted_report_with_existing_tests
        @sorted_report_with_existing_tests ||= sorted_report.select { |test_path, time| all_tests.include?(test_path) }
      end

      def total_time_execution
        @total_time_execution ||= sorted_report_with_existing_tests.map(&:last).reduce(0, :+).to_f
      end

      def node_time_execution
        @node_time_execution ||= total_time_execution / ci_node_total
      end

      private

      def post_assign_test_files_to_node
        assign_slow_test_files
        assign_remaining_test_files
      end

      def post_tests_for_node(node_index)
        node_test = node_tests[node_index]
        return unless node_test
        node_test[:test_files_with_time].map(&:first)
      end

      def default_node_tests
        @node_tests = []
        ci_node_total.times do |index|
          @node_tests << {
            node_index: index,
            time_left: node_time_execution,
            test_files_with_time: []
          }
        end
      end

      def assign_slow_test_files
        @not_assigned_test_files = []
        node_index = 0
        sorted_report_with_existing_tests.each do |test_file_with_time|
          assign_slow_test_file(node_index, test_file_with_time)
          node_index += 1
          node_index %= ci_node_total
        end
      end

      def assign_slow_test_file(node_index, test_file_with_time)
        time = test_file_with_time[1]
        time_left = node_tests[node_index][:time_left] - time

        if time_left >= 0 or node_tests[node_index][:test_files_with_time].empty?
          node_tests[node_index][:time_left] -= time
          node_tests[node_index][:test_files_with_time] << test_file_with_time
        else
          @not_assigned_test_files << test_file_with_time
        end
      end

      def assign_remaining_test_files
        @not_assigned_test_files.each do |test_file_with_time|
          index = node_with_max_time_left
          time = test_file_with_time[1]
          node_tests[index][:time_left] -= time
          node_tests[index][:test_files_with_time] << test_file_with_time
        end
      end

      def node_with_max_time_left
        node_test = node_tests.max { |a,b| a[:time_left] <=> b[:time_left] }
        node_test[:node_index]
      end
    end
  end
end
