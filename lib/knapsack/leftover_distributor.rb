module Knapsack
  class LeftoverDistributor
    attr_reader :report, :spec_pattern

    def initialize(args={})
      @report = args[:report] || default_report
      @spec_pattern = args[:spec_pattern] || default_spec_pattern
    end

    def default_report
      Knapsack.report.open
    end

    def default_spec_pattern
      'spec/**/*_spec.rb'
    end

    def reported_specs
      @reported_specs ||= @report.keys
    end

    def all_specs
      @all_specs ||= Dir[spec_pattern]
    end

    def leftover_specs
      @leftover_specs ||= all_specs - reported_specs
    end
  end
end
