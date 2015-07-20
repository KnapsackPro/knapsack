module Knapsack
  module Runners
    class CucumberRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::CucumberAdapter).allocator

        puts
        puts 'Report features:'
        puts allocator.report_node_tests
        puts
        puts 'Leftover features:'
        puts allocator.leftover_node_tests
        puts

        cmd = %Q[bundle exec cucumber #{args} -- #{allocator.stringify_node_tests}]

        system(cmd)
        exit($?.exitstatus)
      end
    end
  end
end
