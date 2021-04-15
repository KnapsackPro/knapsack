module Knapsack
  class Tracker
    include Singleton

    attr_reader :global_time, :test_files_with_time
    attr_writer :test_path

    def initialize
      set_defaults
    end

    def config(opts={})
      @config ||= default_config
      @config.merge!(opts)
    end

    def reset!
      set_defaults
    end

    def start_timer
      @start_time = now_without_mock_time.to_f
    end

    def stop_timer
      execution_time = now_without_mock_time.to_f - @start_time

      if test_path
        update_global_time(execution_time)
        update_test_file_time(execution_time)
        @test_path = nil
      end

      execution_time
    end

    def test_path
      @test_path.sub(/^\.\//, '') if @test_path
    end

    def time_exceeded?
      global_time > max_node_time_execution
    end

    def max_node_time_execution
      report_distributor.node_time_execution + config[:time_offset_in_seconds]
    end

    def exceeded_time
      global_time - max_node_time_execution
    end

    private

    def default_config
      {
        enable_time_offset_warning: Config::Tracker.enable_time_offset_warning,
        time_offset_in_seconds: Config::Tracker.time_offset_in_seconds,
        generate_report: Config::Tracker.generate_report
      }
    end

    def set_defaults
      @global_time = 0
      @test_files_with_time = {}
      @test_path = nil
    end

    def update_global_time(execution_time)
      @global_time += execution_time
    end

    def update_test_file_time(execution_time)
      @test_files_with_time[test_path] ||= 0
      @test_files_with_time[test_path] += execution_time
    end

    def report_distributor
      @report_distributor ||= Knapsack::Distributors::ReportDistributor.new({
        report: Knapsack.report.open,
        test_file_pattern: Knapsack::Config::Env.test_file_pattern || Knapsack.report.config[:test_file_pattern],
        ci_node_total: Knapsack::Config::Env.ci_node_total,
        ci_node_index: Knapsack::Config::Env.ci_node_index
      })
    end

    def now_without_mock_time
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  end
end
