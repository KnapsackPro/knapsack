require 'singleton'
require 'rake/testtask'
require_relative 'extensions/time'
require_relative 'knapsack/version'
require_relative 'knapsack/config/env'
require_relative 'knapsack/config/tracker'
require_relative 'knapsack/logger'
require_relative 'knapsack/tracker'
require_relative 'knapsack/presenter'
require_relative 'knapsack/report'
require_relative 'knapsack/allocator'
require_relative 'knapsack/allocator_builder'
require_relative 'knapsack/task_loader'
require_relative 'knapsack/distributors/base_distributor'
require_relative 'knapsack/distributors/report_distributor'
require_relative 'knapsack/distributors/leftover_distributor'
require_relative 'knapsack/adapters/base_adapter'
require_relative 'knapsack/adapters/rspec_adapter'
require_relative 'knapsack/adapters/cucumber_adapter'
require_relative 'knapsack/adapters/minitest_adapter'
require_relative 'knapsack/adapters/spinach_adapter'
require_relative 'knapsack/runners/rspec_runner'
require_relative 'knapsack/runners/cucumber_runner'
require_relative 'knapsack/runners/minitest_runner'
require_relative 'knapsack/runners/spinach_runner'

module Knapsack
  class << self
    @@logger = nil

    def tracker
      Knapsack::Tracker.instance
    end

    def report
      Knapsack::Report.instance
    end

    def root
      File.expand_path('../..', __FILE__)
    end

    def load_tasks
      task_loader = Knapsack::TaskLoader.new
      task_loader.load_tasks
    end

    def logger
      return @@logger if @@logger
      log = Knapsack::Logger.new
      log.level = Knapsack::Config::Env.log_level
      @@logger = log
    end

    def logger=(value)
      @@logger = value
    end
  end
end
