module Knapsack
  module Distributors
    class LeftoverDistributor < BaseDistributor
      attr_reader :spec_pattern

      def report_specs
        @report_specs ||= @report.keys
      end

      def all_specs
        @all_specs ||= Dir[spec_pattern]
      end

      def leftover_specs
        @leftover_specs ||= all_specs - report_specs
      end

      private

      def post_initialize(args={})
        @spec_pattern = args[:spec_pattern] || default_spec_pattern
      end

      def default_spec_pattern
        'spec/**/*_spec.rb'
      end

      def post_assign_spec_files_to_node
        leftover_specs.each do |spec_file|
          node_specs[@node_index] << spec_file
          update_node_index
        end
      end

      def post_specs_for_node(node_index)
        spec_files = node_specs[node_index]
        return unless spec_files
        spec_files
      end

      def default_node_specs
        @node_specs = []
        ci_node_total.times do |index|
          @node_specs[index] = []
        end
      end
    end
  end
end
