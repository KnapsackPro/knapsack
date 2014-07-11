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

      def time_offset
        "Time offset: #{Knapsack.tracker.config[:time_offset_in_seconds]}s"
      end

      def max_allowed_node_time_execution
        "Max allowed node time execution: #{Knapsack.tracker.max_node_time_execution}s"
      end

      def exceeded_time
        "Exceeded time: #{Knapsack.tracker.exceeded_time}s"
      end

      def time_offset_warning
        str = %{\n========= Knapsack Time Offset Warning ==========
#{Presenter.time_offset}
#{Presenter.max_allowed_node_time_execution}
#{Presenter.exceeded_time}
        }
        if Knapsack.tracker.time_exceeded?
          str << %{
Specs on this CI node took more than time offset.
Please regenerate your knapsack report.
If that didn't help then split your heavy test file
or bump time_offset_in_seconds setting.
          }
        else
          str << %{
Global time execution for this CI node is fine.
Happy testing!}
        end
        str << "\n=================================================\n"
        str
      end
    end
  end
end
