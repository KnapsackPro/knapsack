require 'knapsack'

namespace :knapsack do
  task :cucumber do
    allocator = Knapsack::Allocator.new({
      spec_pattern: 'features/**/*.feature'
    })

    puts
    puts 'Report features:'
    puts allocator.report_node_specs
    puts
    puts 'Leftover features:'
    puts allocator.leftover_node_specs
    puts

    cmd = %Q[bundle exec cucumber -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
