module Knapsack
  module Runners
    class SpinachRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::SpinachAdapter).allocator

        Knapsack.logger.info
        Knapsack.logger.info 'Report features:'
        Knapsack.logger.info allocator.report_node_tests
        Knapsack.logger.info
        Knapsack.logger.info 'Leftover features:'
        Knapsack.logger.info allocator.leftover_node_tests
        Knapsack.logger.info

        # NOTE: return if there are no specs to execute for this node.
        # This can occurr if test_file_list_source_file is used with less then CI_NODES specs
        return Knapsack.logger.warn('No specs to execute') if allocator.stringify_node_tests.empty?

        cmd = %Q[bundle exec spinach #{args} --features_path #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

        system(cmd)
        exit($?.exitstatus) unless $?.exitstatus == 0
      end
    end
  end
end
