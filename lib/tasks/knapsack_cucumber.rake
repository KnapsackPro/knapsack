require 'knapsack'

namespace :knapsack do
  task :cucumber, [:cucumber_args] do |t, args|
    cucumber_args = args[:cucumber_args]

    allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::CucumberAdapter).allocator

    puts
    puts 'Report features:'
    puts allocator.report_node_tests
    puts
    puts 'Leftover features:'
    puts allocator.leftover_node_tests
    puts

    cmd = %Q[bundle exec cucumber #{cucumber_args} -- #{allocator.stringify_node_tests}]

    exec(cmd)
  end
end
