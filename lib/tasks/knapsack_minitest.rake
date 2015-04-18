require 'knapsack'

namespace :knapsack do
  task :minitest, [:minitest_args] do |t, args|
    allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::MinitestAdapter).allocator

    puts
    puts 'Report tests:'
    puts allocator.report_node_tests
    puts
    puts 'Leftover tests:'
    puts allocator.leftover_node_tests
    puts

    # FIXME this should be run as one commad
    cmd = ''
    allocator.node_tests.each do |test_file_path|
      cmd += %Q[ruby #{args[:minitest_args]} #{test_file_path};]
    end

    exec(cmd)
  end
end
