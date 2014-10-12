require 'knapsack'

namespace :knapsack do
  task :rspec do
    Knapsack.report.config({
      report_path: Knapsack::Adapters::RspecAdapter::REPORT_PATH
    })

    allocator = Knapsack::Allocator.new({
      spec_pattern: Knapsack::Adapters::RspecAdapter::TEST_DIR_PATTERN
    })

    puts
    puts 'Report specs:'
    puts allocator.report_node_specs
    puts
    puts 'Leftover specs:'
    puts allocator.leftover_node_specs
    puts

    cmd = %Q[bundle exec rspec --default-path #{allocator.spec_dir} -- #{allocator.stringify_node_specs}]

    exec(cmd)
  end
end
