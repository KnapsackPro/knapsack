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

    custom_spec_dir = allocator.custom_spec_dir
    default_path = custom_spec_dir ? "--default-path #{custom_spec_dir}" : nil
    cmd = %Q[bundle exec rspec #{default_path} -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
