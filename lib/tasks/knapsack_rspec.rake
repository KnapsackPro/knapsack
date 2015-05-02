require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args] do |_, args|
    allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::RspecAdapter).allocator

    puts
    puts 'Report specs:'
    puts allocator.report_node_tests
    puts
    puts 'Leftover specs:'
    puts allocator.leftover_node_tests
    puts

    cmd = %Q[bundle exec rspec #{args[:rspec_args]} --default-path #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

    system(cmd)
    exit($?.exitstatus)
  end
end
