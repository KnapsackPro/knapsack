require 'singleton'
require 'knapsack/version'
require 'knapsack/tracker'
require 'knapsack/presenter'
require 'knapsack/report'
require 'knapsack/distributor'
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

    def root
      File.expand_path '../..', __FILE__
    end
  end
end
