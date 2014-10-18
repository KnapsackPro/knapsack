require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args] do |t, args|
    rspec_args = args[:rspec_args]

    Knapsack.report.config({
      report_path: Knapsack::Config::Env.report_path || Knapsack::Adapters::RspecAdapter::REPORT_PATH
    })

    allocator = Knapsack::Allocator.new({
      report: Knapsack.report.open,
      ci_node_total: Knapsack::Config::Env.ci_node_total,
      ci_node_index: Knapsack::Config::Env.ci_node_index,
      spec_pattern: Knapsack::Config::Env.spec_pattern || Knapsack::Adapters::RspecAdapter::TEST_DIR_PATTERN
    })

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
