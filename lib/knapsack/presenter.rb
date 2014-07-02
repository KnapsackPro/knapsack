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
        "Global time execution: #{Knapsack.tracker.global_time}"
      end
    end
  end
end
