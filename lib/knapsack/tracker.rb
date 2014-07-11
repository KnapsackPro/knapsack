module Knapsack
  class Tracker
    include Singleton

    attr_reader :global_time, :spec_files_with_time
    attr_writer :spec_path

    def initialize
      set_defaults
    end

    def generate_report?
      ENV['KNAPSACK_GENERATE_REPORT'] || false
    end

    def config(opts={})
      @config ||= default_config
      @config.merge!(opts)
    end

    def reset!
      set_defaults
    end

    def start_timer
      @start_time = Time.now.to_f
    end

    def stop_timer
      @execution_time = Time.now.to_f - @start_time
      update_global_time
      update_spec_file_time
      @execution_time
    end

    def spec_path
      raise("spec_path needs to be set by Knapsack Adapter's bind method") unless @spec_path
      @spec_path.sub(/^\.\//, '')
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
        enable_time_offset_warning: true,
        time_offset_in_seconds: 30,
      }
    end

    def set_defaults
      @global_time = 0
      @spec_files_with_time = {}
      @spec_path = nil
    end

    def update_global_time
      @global_time += @execution_time
    end

    def update_spec_file_time
      @spec_files_with_time[spec_path] ||= 0
      @spec_files_with_time[spec_path] += @execution_time
    end

    def report_distributor
      @report_distributor ||= Knapsack::Distributors::ReportDistributor.new
    end
  end
end
