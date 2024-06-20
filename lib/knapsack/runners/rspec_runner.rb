module Knapsack
  module Runners
    class RSpecRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::RSpecAdapter).allocator

        Knapsack.logger.info
        puts ''
        Knapsack.logger.info 'Report specs:'
        puts 'Report specs:'
        Knapsack.logger.info allocator.report_node_tests
        puts allocator.report_node_tests
        Knapsack.logger.info
        puts ''
        Knapsack.logger.info 'Leftover specs:'
        puts 'Leftover specs:'
        Knapsack.logger.info allocator.leftover_node_tests
        puts allocator.leftover_node_tests
        Knapsack.logger.info
        puts

        # NOTE: return if there are no specs to execute for this node.
        # This can occurr if test_file_list_source_file is used with less then CI_NODES specs
        return Knapsack.logger.warn('No specs to execute') if allocator.stringify_node_tests.empty?

        cmd = %Q[bundle exec rspec #{args} --default-path #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

        exec(cmd)
      end
    end
  end
end
