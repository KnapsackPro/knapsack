require 'knapsack'

namespace :knapsack do
  task :cucumber do
    Knapsack.report.config({
      report_path: Knapsack::Adapters::CucumberAdapter::REPORT_PATH
    })

    allocator = Knapsack::Allocator.new({
      spec_pattern: Knapsack::Adapters::CucumberAdapter::TEST_DIR_PATTERN
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
