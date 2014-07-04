module Knapsack
  module Adapters
    class Base
      def self.bind
        new
      end

      protected

      def initialize
        if Knapsack.tracker.generate_report?
          puts 'Knapsack report generator started!'
          bind_time_tracker
          bind_report_generator
        elsif Knapsack.tracker.config[:enable_time_offset_warning]
          puts 'Knapsack time offset warning enabled!'
          bind_time_tracker
          # TODO
        else
          puts 'Knapsack is off!'
        end
      end

      def bind_time_tracker
        raise NotImplementedError
      end

      def bind_report_generator
        raise NotImplementedError
      end
    end
  end
end
