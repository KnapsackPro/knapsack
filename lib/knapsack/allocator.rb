module Knapsack
  class Allocator
    def initialize(args={})
      args = default_args.merge(args)
      @report_distributor = Knapsack::Distributors::ReportDistributor.new(args)
      @leftover_distributor = Knapsack::Distributors::LeftoverDistributor.new(args)
    end

    def report_node_specs
      @report_node_specs ||= @report_distributor.specs_for_current_node
    end

    def leftover_node_specs
      @leftover_node_specs ||= @leftover_distributor.specs_for_current_node
    end

    def node_specs
      @node_specs ||= report_node_specs + leftover_node_specs
    end

    def stringify_node_specs
      node_specs.join(' ')
    end

    private

    def default_args
      {
        ci_node_total: ci_node_total,
        ci_node_index: ci_node_index,
        spec_pattern: spec_pattern
      }
    end

    def ci_node_total
      ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL']
    end

    def ci_node_index
      ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX']
    end

    def spec_pattern
      ENV['KNAPSACK_SPEC_PATTERN']
    end
  end
end
