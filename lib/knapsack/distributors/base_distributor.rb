module Knapsack
  module Distributors
    class BaseDistributor
      attr_reader :report, :node_tests, :test_file_pattern

      def initialize(args={})
        @report = args[:report] || raise('Missing report')
        @test_file_pattern = args[:test_file_pattern] || raise('Missing test_file_pattern')
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
        @all_tests ||= (
          Dir.glob(test_file_pattern)
            .flat_map { |test_file| 
              slow_spec_file = slow_spec_file_for(test_file)
              if slow_spec_file.nil?
                [test_file]
              else
                Knapsack::Config::Env.slow_spec_examples.map { |slow_spec_example| slow_spec_example.sub(slow_spec_file, test_file) }
              end
            } 
        ).uniq.sort
      end

      def slow_spec_file_for(test_file)
        Knapsack::Config::Env.slow_spec_files.detect { |slow_spec_path| test_file =~ Regexp.new(slow_spec_path) }
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
