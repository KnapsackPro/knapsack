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
        default_node_specs
        @node_index = 0
        leftover_specs.each do |spec_file|
          node_specs[@node_index] << spec_file
          update_node_index
        end
      end

      def specs_for_node(node_index)
        assign_spec_files_to_node
        spec_files = node_specs[node_index]
        return unless spec_files
        spec_files
      end

      private

      def default_node_specs
        @node_specs = []
        ci_node_total.times do |index|
          @node_specs[index] = []
        end
      end

      def update_node_index
        @node_index += 1
        @node_index = 0 if @node_index == ci_node_total
      end
    end
  end
end
