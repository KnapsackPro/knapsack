module Knapsack
  module Distributors
    class BaseDistributor
      attr_reader :report, :node_tests, :test_file_pattern, :test_file_list_source_file

      def initialize(args={})
        @report = args[:report] || raise('Missing report')
        @test_file_pattern = args[:test_file_pattern] || raise('Missing test_file_pattern')
        @test_file_list_source_file = args[:test_file_list_source_file]
        @ci_node_total = args[:ci_node_total] || raise('Missing ci_node_total')
        @ci_node_index = args[:ci_node_index] || raise('Missing ci_node_index')

        if ci_node_index >= ci_node_total
          raise("Node indexes are 0-based. Can't be higher or equal to the total number of nodes.")
        end
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
        @all_tests ||= test_files
      end

      # NOTE: Use the test_file_pattern by default
      # support specifying a list_file to use similar to KnapsackPro
      # ref: KnapsackPro/knapsack_pro-ruby/commit/7d7b8db8be524f2f30d7d80d3a6444dad9f85b1b
      def test_files
        return Dir.glob(test_file_pattern).uniq.sort if test_file_list_source_file.nil?

        File.read(test_file_list_source_file)
          .split(/\n/)
          .uniq
          .sort
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
