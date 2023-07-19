module Knapsack
  module Config
    class Tracker
      class << self
        def enable_time_offset_warning
          true
        end

        def time_offset_in_seconds
          30
        end

        def generate_report
          !!(ENV['KNAPSACK_GENERATE_REPORT'] =~ /\Atrue|0\z/i)
        end

        def merge_report
          !!(ENV['KNAPSACK_MERGE_REPORT'] =~ /\Atrue|0\z/i)
        end
      end
    end
  end
end
