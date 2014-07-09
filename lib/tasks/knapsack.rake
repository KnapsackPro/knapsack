require 'knapsack'

namespace :knapsack do
  task :rspec do
    ci_node_total = ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL']
    ci_node_index = ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX']
    spec_pattern = ENV['KNAPSACK_SPEC_PATTERN']

    args = {
      ci_node_total: ci_node_total,
      ci_node_index: ci_node_index,
      spec_pattern: spec_pattern
    }
    report_distributor = Knapsack::Distributors::ReportDistributor.new(args)
    leftover_distributor = Knapsack::Distributors::LeftoverDistributor.new(args)

    puts 'Report specs:'
    puts report_distributor.specs_for_current_node.join(' ')
    puts 'Leftover specs:'
    puts leftover_distributor.specs_for_current_node.join(' ')

    spec_paths = report_distributor.specs_for_current_node + leftover_distributor.specs_for_current_node
    spec_paths = spec_paths.join(' ')

    puts `bundle exec rspec --color --profile -- #{spec_paths}`
  end
end
