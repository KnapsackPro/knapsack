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
        "Knapsack global time execution for specs: #{Knapsack.tracker.global_time}s"
      end
    end
  end
end
