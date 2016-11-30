module Knapsack
  module Runners
    class RSpecRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::RSpecAdapter).allocator

        Knapsack.logger.info
        Knapsack.logger.info 'Report specs:'
        Knapsack.logger.info allocator.report_node_tests
        Knapsack.logger.info
        Knapsack.logger.info 'Leftover specs:'
        Knapsack.logger.info allocator.leftover_node_tests
        Knapsack.logger.info

        cmd = %Q[bundle exec rspec #{args} --default-path #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

        system(cmd)
        exit($?.exitstatus) unless $?.exitstatus == 0
      end
    end
  end
end
