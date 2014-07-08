module Knapsack
  module Distributors
    class LeftoverDistributor < BaseDistributor
      attr_reader :spec_pattern

      def initialize(args={})
        @spec_pattern = args[:spec_pattern] || default_spec_pattern
        super(args)
      end

      def default_spec_pattern
        'spec/**/*_spec.rb'
      end

      def report_specs
        @report_specs ||= @report.keys
      end

      def all_specs
        @all_specs ||= Dir[spec_pattern]
      end

      def leftover_specs
        @leftover_specs ||= all_specs - report_specs
      end

      def assign_spec_files_to_node
        # TODO
      end

      def specs_for_node(node_index)
        assign_spec_files_to_node
        # TODO
      end
    end
  end
end
