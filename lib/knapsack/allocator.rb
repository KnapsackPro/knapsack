module Knapsack
  class Allocator
    def initialize(args={})
      @spec_pattern = Config.spec_pattern || args[:spec_pattern]
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

    def spec_dir
      @spec_pattern.gsub(/^(.*?)\//).first
    end
  end
end
