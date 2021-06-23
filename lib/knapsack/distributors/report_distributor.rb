module Knapsack
  module Distributors
    class ReportDistributor < BaseDistributor
      def sorted_report
        @sorted_report ||= report.sort_by { |_test_path, time| -time }
      end

      def sorted_report_with_existing_tests
        @sorted_report_with_existing_tests ||= sorted_report.select { |test_path, time| all_tests.include?(test_path) }
      end

      def total_time_execution
        @total_time_execution ||= sorted_report_with_existing_tests.map { |_test_path, time| time }.reduce(0, :+).to_f
      end

      def node_time_execution
        @node_time_execution ||= total_time_execution / ci_node_total
      end

      private

      def post_assign_test_files_to_node
        assign_test_files
        sort_assigned_test_files
      end

      def sort_assigned_test_files
        node_tests.map do |node|
          node[:test_files_with_time].sort_by! { |file_name, _time| -file_name }
                                     .sort_by! { |_file_name, time| -time }
        end
      end

      def post_tests_for_node(node_index)
        node_test = node_tests[node_index]
        return unless node_test
        node_test[:test_files_with_time].map { |file_name, _time| file_name }
      end

      def default_node_tests
        @node_tests = Array.new(ci_node_total) do |index|
          {
            node_index: index,
            time_left: node_time_execution,
            test_files_with_time: [],
            weight: 0
          }
        end
      end

      def assign_test_files
        sorted_report_with_existing_tests.map do |test_file_with_time|
          test_execution_time = test_file_with_time.last

          current_lightest_node = node_tests.min_by { |node| node[:weight] }

          updated_node_data = {
            time_left:            current_lightest_node[:time_left] - test_execution_time,
            weight:               current_lightest_node[:weight] + test_execution_time,
            test_files_with_time: current_lightest_node[:test_files_with_time] << test_file_with_time
          }

          current_lightest_node.merge!(updated_node_data)
        end
      end
    end
  end
end
