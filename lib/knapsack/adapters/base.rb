module Knapsack
  module Adapters
    class Base
      def self.bind
        adapter = new
        adapter.bind
        adapter
      end

      def bind
        if tracker.generate_report?
          puts 'Knapsack report generator started!'
          bind_time_tracker
          bind_report_generator
        elsif tracker.config[:enable_time_offset_warning]
          puts 'Knapsack time offset warning enabled!'
          bind_time_tracker
          # TODO
        else
          puts 'Knapsack is off!'
        end
      end

      protected

      def tracker
        Knapsack.tracker
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
