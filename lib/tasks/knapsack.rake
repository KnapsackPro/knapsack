require 'knapsack'

namespace :knapsack do
  task :rspec do
    allocator = Knapsack::Allocator.new

    puts
    puts 'Report specs:'
    puts allocator.report_node_specs
    puts
    puts 'Leftover specs:'
    puts allocator.leftover_node_specs
    puts

    cmd = "bundle exec rspec #{allocator.stringify_node_specs}"
    exec(cmd)
  end
end
