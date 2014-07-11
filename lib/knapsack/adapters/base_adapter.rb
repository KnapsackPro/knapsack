module Knapsack
  module Adapters
    class BaseAdapter
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
          bind_time_offset_warning
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

      def bind_time_offset_warning
        raise NotImplementedError
      end

      protected

      def tracker
        Knapsack.tracker
      end
    end
  end
end
