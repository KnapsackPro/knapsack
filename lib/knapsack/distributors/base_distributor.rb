module Knapsack
  module Distributors
    class BaseDistributor
      attr_reader :report, :ci_node_total, :ci_node_index, :node_specs

      DEFAULT_CI_NODE_TOTAL = 1
      DEFAULT_CI_NODE_INDEX = 0

      def initialize(args={})
        @report = args[:report] || default_report
        @ci_node_total = args[:ci_node_total] || DEFAULT_CI_NODE_TOTAL
        @ci_node_index = args[:ci_node_index] || DEFAULT_CI_NODE_INDEX
      end

      def default_report
        Knapsack.report.open
      end

      def specs_for_current_node
        specs_for_node(ci_node_index)
      end

      def specs_for_node(node_index)
        assign_spec_files_to_node
        raise NotImplementedError
      end

      def assign_spec_files_to_node
        raise NotImplementedError
      end
    end
  end
end
