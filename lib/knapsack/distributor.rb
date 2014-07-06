module Knapsack
  class Distributor
    attr_reader :report, :ci_node_total, :ci_node_index, :node_specs

    DEFAULT_CI_NODE_TOTAL = 1
    DEFAULT_CI_NODE_INDEX = 0

    def initialize(args={})
      @report = args[:report] || default_report
      @ci_node_total = args[:ci_node_total] || DEFAULT_CI_NODE_TOTAL
      @ci_node_index = args[:ci_node_index] || DEFAULT_CI_NODE_INDEX
      set_node_specs
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

    def assign_spec_file_per_node
      (0...ci_node_total).each do |node_index|
        time_left = node_time_execution
        sorted_report.each do |spec_file_with_time|
          spec_file = spec_file_with_time[0]
          time = spec_file_with_time[1]

          time_left -= time
          if time_left >= 0
            @node_specs[node_index] << spec_file
            sorted_report.delete(spec_file_with_time)
          else
            next
          end
        end
      end
    end

    def set_node_specs
      @node_specs = []
      ci_node_total.times do |index|
        @node_specs << []
      end
    end
  end
end
