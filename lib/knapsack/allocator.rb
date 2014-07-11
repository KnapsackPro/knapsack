module Knapsack
  class Allocator
    def initialize(args={})
      @config = default_args.merge(args)
      @report_distributor = Knapsack::Distributors::ReportDistributor.new(@config)
      @leftover_distributor = Knapsack::Distributors::LeftoverDistributor.new(@config)
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

    def custom_spec_dir
      return unless @config[:spec_pattern]
      @config[:spec_pattern].gsub(/^(.*?)\//).first
    end

    private

    def default_args
      {
        ci_node_total: env_ci_node_total,
        ci_node_index: env_ci_node_index,
        spec_pattern: env_spec_pattern,
        report: report
      }
    end

    def env_ci_node_total
      ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL']
    end

    def env_ci_node_index
      ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX']
    end

    def env_spec_pattern
      ENV['KNAPSACK_SPEC_PATTERN']
    end

    def env_report_path
      ENV['KNAPSACK_REPORT_PATH']
    end

    def report
      return unless env_report_path
      Knapsack.report.config({
        report_path: env_report_path
      })
      Knapsack.report.open
    end
  end
end
