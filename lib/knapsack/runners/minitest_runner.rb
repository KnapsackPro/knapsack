module Knapsack
  module Runners
    class MinitestRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::MinitestAdapter).allocator

        puts
        puts 'Report tests:'
        puts allocator.report_node_tests
        puts
        puts 'Leftover tests:'
        puts allocator.leftover_node_tests
        puts

        task_name = 'knapsack:minitest_run'

        if Rake::Task.task_defined?(task_name)
          Rake::Task[task_name].clear
        end

        Rake::TestTask.new(task_name) do |t|
          t.libs << allocator.test_dir
          t.test_files = allocator.node_tests
          t.options = args
        end

        Rake::Task[task_name].invoke
      end
    end
  end
end
