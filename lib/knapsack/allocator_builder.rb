module Knapsack
  class AllocatorBuilder
    def initialize(adapter_class)
      @adapter_class = adapter_class
      set_report_path
    end

    def allocator
      Knapsack::Allocator.new({
        report: Knapsack.report.open,
        ci_node_total: Knapsack::Config::Env.ci_node_total,
        ci_node_index: Knapsack::Config::Env.ci_node_index,
        spec_pattern: spec_pattern
      })
    end

    private

    def set_report_path
      Knapsack.report.config({
        report_path: report_path
      })
    end

    def report_path
      Knapsack::Config::Env.report_path || @adapter_class::REPORT_PATH
    end

    def spec_pattern
      Knapsack::Config::Env.spec_pattern || @adapter_class::TEST_DIR_PATTERN
    end
  end
end
