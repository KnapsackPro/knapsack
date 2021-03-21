module Knapsack
  class AllocatorBuilder
    def initialize(adapter_class)
      @adapter_class = adapter_class
      set_report_path
    end

    def allocator
      Knapsack::Allocator.new({
        report: Knapsack.report.open,
        test_file_pattern: test_file_pattern,
        test_file_list_source_file: test_file_list_source_file,
        ci_node_total: Knapsack::Config::Env.ci_node_total,
        ci_node_index: Knapsack::Config::Env.ci_node_index
      })
    end

    def test_dir
      Knapsack::Config::Env.test_dir || test_file_pattern.split('/').first
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

    def test_file_pattern
      Knapsack::Config::Env.test_file_pattern || @adapter_class::TEST_DIR_PATTERN
    end

    def test_file_list_source_file
      Knapsack::Config::Env.test_file_list_source_file
    end
  end
end
