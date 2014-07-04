require 'yaml'
require 'json'

module Knapsack
  class Presenter
    class << self
      def report_yml
        Knapsack.tracker.files.to_yaml
      end

      def report_json
        JSON.pretty_generate(Knapsack.tracker.files)
      end

      def global_time
        "Knapsack global time execution for specs: #{Knapsack.tracker.global_time}s"
      end

      def report_details
        "Knapsack report was generated. Preview:\n" + Presenter.report_json
      end
    end
  end
end
