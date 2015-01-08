module Knapsack
  module Distributors
    class BaseDistributor
      attr_reader :report, :node_tests, :test_file_pattern

      def initialize(args={})
        @report = args[:report] || raise('Missing report')
        @test_file_pattern = args[:test_file_pattern] || raise('Missing test_file_pattern')
        @ci_node_total = args[:ci_node_total] || raise('Missing ci_node_total')
        @ci_node_index = args[:ci_node_index] || raise('Missing ci_node_index')
      end

      def ci_node_total
        @ci_node_total.to_i
      end

      def ci_node_index
        @ci_node_index.to_i
      end

      def tests_for_current_node
        tests_for_node(ci_node_index)
      end

      def tests_for_node(node_index)
        assign_test_files_to_node
        post_tests_for_node(node_index)
      end

      def assign_test_files_to_node
        default_node_tests
        post_assign_test_files_to_node
      end

      def all_tests
        @all_tests ||= Dir[test_file_pattern].sort
      end

      protected

      def post_tests_for_node(node_index)
        raise NotImplementedError
      end

      def post_assign_test_files_to_node
        raise NotImplementedError
      end

      def default_node_tests
        raise NotImplementedError
      end
    end
  end
end
