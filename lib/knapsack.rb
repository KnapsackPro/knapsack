require 'singleton'
require 'knapsack/version'
require 'knapsack/tracker'
require 'knapsack/presenter'
require 'knapsack/report'
require 'knapsack/adapters/base'
require 'knapsack/adapters/rspec'

module Knapsack
  class << self
    def tracker
      Knapsack::Tracker.instance
    end

    def report
      Knapsack::Report.instance
    end
  end
end
