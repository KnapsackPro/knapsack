require 'knapsack'

namespace :knapsack do
  task :cucumber, [:cucumber_args] do |t, args|
    cucumber_args = args[:cucumber_args]

    allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::CucumberAdapter).allocator

    puts
    puts 'Report features:'
    puts allocator.report_node_specs
    puts
    puts 'Leftover features:'
    puts allocator.leftover_node_specs
    puts

    cmd = %Q[bundle exec cucumber #{cucumber_args} -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
