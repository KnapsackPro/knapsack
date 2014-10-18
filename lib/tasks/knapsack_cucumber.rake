require 'knapsack'

namespace :knapsack do
  task :cucumber, [:cucumber_args] do |t, args|
    cucumber_args = args[:cucumber_args]

    Knapsack.report.config({
      report_path: Knapsack::Config::Env.report_path || Knapsack::Adapters::CucumberAdapter::REPORT_PATH
    })

    allocator = Knapsack::Allocator.new({
      report: Knapsack.report.open,
      ci_node_total: Knapsack::Config::Env.ci_node_total,
      ci_node_index: Knapsack::Config::Env.ci_node_index,
      spec_pattern: Knapsack::Config::Env.spec_pattern || Knapsack::Adapters::CucumberAdapter::TEST_DIR_PATTERN
    })

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
