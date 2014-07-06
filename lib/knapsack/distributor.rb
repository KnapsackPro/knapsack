module Knapsack
  class Distributor
    attr_reader :report, :ci_node_total, :ci_node_index

    def initialize(args={})
      @report = args[:report] || default_report
      @ci_node_total = args[:ci_node_total] || default_ci_node_total
      @ci_node_index = args[:ci_node_index] || default_ci_node_index
    end

    def default_report
      Knapsack.report.open
    end

    def default_ci_node_total
      ENV['CI_NODE_TOTAL'] || 1
    end

    def default_ci_node_index
      ENV['CI_NODE_INDEX'] || 0
    end
  end
end
