module Knapsack
  module Distributors
    class LeftoverDistributor < BaseDistributor
      def report_tests
        @report_tests ||= report.keys
      end

      def leftover_tests
        @leftover_tests ||= (all_tests - report_tests).reject { |test_path| Knapsack::Config::Env.slow_spec_files.any? { |slow_spec_path| slow_spec_path =~ Regexp.new(test_path.sub(/^\.\//, ''))} }
      end

      private

      def post_assign_test_files_to_node
        node_index = 0
        leftover_tests.each do |test_file|
          node_tests[node_index] << test_file
          node_index += 1
          node_index %= ci_node_total
        end
      end

      def post_tests_for_node(node_index)
        test_files = node_tests[node_index]
        return unless test_files
        test_files
      end

      def default_node_tests
        @node_tests = []
        ci_node_total.times do |index|
          @node_tests[index] = []
        end
      end
    end
  end
end
