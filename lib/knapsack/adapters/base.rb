module Knapsack
  module Adapters
    class Base
      def self.bind
        new
      end

      def initialize
        return unless Knapsack.tracker.enabled?
        puts 'Knapsack started!'
        default_bind
      end

      def default_bind
        raise NotImplementedError
      end
    end
  end
end
