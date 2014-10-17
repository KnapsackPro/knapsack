require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args] do |t, args|
    allocator = Knapsack::Allocator.new
    rspec_args = args[:rspec_args]

    puts
    puts 'Report specs:'
    puts allocator.report_node_specs
    puts
    puts 'Leftover specs:'
    puts allocator.leftover_node_specs
    puts

    cmd = %Q[bundle exec rspec #{rspec_args} --default-path #{allocator.spec_dir} -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
