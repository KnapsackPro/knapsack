require 'singleton'

module Knapsack
  class Tracker
    include Singleton

    attr_reader :global_time, :files
    attr_writer :spec_path

    def initialize
      set_defaults
    end

    def enabled?
      ENV['KNAPSACK_TRACKER_ENABLED'] || false
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

    private

    def set_defaults
      @global_time = 0
      @files = {}
    end

    def update_global_time
      @global_time += @execution_time
    end

    def update_spec_file_time
      @files[spec_path] ||= 0
      @files[spec_path] += @execution_time
    end

    def spec_path
      @spec_path || raise("spec_path needs to be set by Knapsack Adapter's bind method")
    end
  end
end
