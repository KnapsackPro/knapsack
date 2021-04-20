module Knapsack
  module Runners
    class MinitestRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::MinitestAdapter).allocator

        Knapsack.logger.info
        Knapsack.logger.info 'Report tests:'
        Knapsack.logger.info allocator.report_node_tests
        Knapsack.logger.info
        Knapsack.logger.info 'Leftover tests:'
        Knapsack.logger.info allocator.leftover_node_tests
        Knapsack.logger.info

        # NOTE: return if there are no specs to execute for this node.
        # This can occurr if test_file_list_source_file is used with less then CI_NODES specs
        return Knapsack.logger.warn('No specs to execute') if allocator.stringify_node_tests.empty?

        task_name = 'knapsack:minitest_run'

        if Rake::Task.task_defined?(task_name)
          Rake::Task[task_name].clear
        end

        Rake::TestTask.new(task_name) do |t|
          t.warning = false
          t.libs << allocator.test_dir
          t.test_files = allocator.node_tests
          t.options = args
        end

        Rake::Task[task_name].invoke
      end
    end
  end
end
