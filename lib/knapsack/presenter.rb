require 'yaml'
require 'json'

module Knapsack
  class Presenter
    class << self
      def report_yml
        Knapsack.tracker.spec_files_with_time.to_yaml
      end

      def report_json
        JSON.pretty_generate(Knapsack.tracker.spec_files_with_time)
      end

      def report_details
        "Knapsack report was generated. Preview:\n" + Presenter.report_json
      end

      def global_time
        "\nKnapsack global time execution for specs: #{Knapsack.tracker.global_time}s"
      end

      def time_exceeded
        str = ''
        str << "\n========= Knapsack Time Offset Warning ==========\n"
        str << "Time offset: #{Knapsack.tracker.config[:time_offset_in_seconds]}s\n"
        str << "Max allowed node time execution: #{Knapsack.tracker.max_node_time_execution}s\n"
        str << "Exceeded time: #{Knapsack.tracker.exceeded_time}s\n\n"
        if Knapsack.tracker.time_exceeded?
          str << "Specs on this CI node took more than time offset.\n"
          str << "Please regenerate your knapsack report.\n"
          str << "If that didn't help then split your heavy test file\n"
          str << "or bump time_offset_in_seconds setting.\n"
        else
          str << "Global time execution for this CI node is fine.\n"
          str << "Happy testing!\n"
        end
        str << "=================================================\n"
        str
      end
    end
  end
end
