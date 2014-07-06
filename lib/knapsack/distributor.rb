module Knapsack
  class Distributor
    attr_reader :report, :ci_node_total, :ci_node_index

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

    def sorted_report
      @sorted_report ||= report.sort_by{|k,v| v}.reverse
    end

    def total_time_execution
      @total_time_execution ||= report.values.reduce(0, :+).to_f
    end

    def node_time_execution
      @node_time_execution ||= total_time_execution / ci_node_total
    end
    end
  end
end
