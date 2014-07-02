require 'knapsack/version'
require 'knapsack/tracker'
require 'knapsack/presenter'
require 'knapsack/rspec/adapter'

module Knapsack
  class << self
    def tracker
      Knapsack::Tracker.instance
    end
  end
end
