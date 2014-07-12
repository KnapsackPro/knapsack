module Knapsack
  module Distributors
    class BaseDistributor
      attr_reader :report, :node_specs, :spec_pattern

      DEFAULT_CI_NODE_TOTAL = 1
      DEFAULT_CI_NODE_INDEX = 0

      def initialize(args={})
        @report = args[:report] || default_report
        @ci_node_total = args[:ci_node_total] || DEFAULT_CI_NODE_TOTAL
        @ci_node_index = args[:ci_node_index] || DEFAULT_CI_NODE_INDEX
        @spec_pattern = args[:spec_pattern] || default_spec_pattern
      end

      def default_report
        Knapsack.report.open
      end

      def ci_node_total
        @ci_node_total.to_i
      end

      def ci_node_index
        @ci_node_index.to_i
      end

      def specs_for_current_node
        specs_for_node(ci_node_index)
      end

      def specs_for_node(node_index)
        assign_spec_files_to_node
        post_specs_for_node(node_index)
      end

      def assign_spec_files_to_node
        default_node_specs
        @node_index = 0
        post_assign_spec_files_to_node
      end

      def all_specs
        @all_specs ||= Dir[spec_pattern]
      end

      protected

      def post_specs_for_node(node_index)
        raise NotImplementedError
      end

      def post_assign_spec_files_to_node
        raise NotImplementedError
      end

      def default_node_specs
        raise NotImplementedError
      end

      private

      def default_spec_pattern
        'spec/**/*_spec.rb'
      end

      def update_node_index
        @node_index += 1
        @node_index = 0 if @node_index == ci_node_total
      end
    end
  end
end
