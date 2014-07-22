require 'knapsack'

namespace :knapsack do
  task :rspec do
    allocator = Knapsack::Allocator.new

    Knapsack.logger.info
    Knapsack.logger.info 'Report specs:'
    Knapsack.logger.info allocator.report_node_specs
    Knapsack.logger.info
    Knapsack.logger.info 'Leftover specs:'
    Knapsack.logger.info allocator.leftover_node_specs
    Knapsack.logger.info

    cmd = %Q[bundle exec rspec --default-path #{allocator.spec_dir} -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
