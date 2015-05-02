require 'knapsack'
require 'rake/testtask'

namespace :knapsack do
  Rake::TestTask.new(:minitest_run) do |t|
    t.libs << 'test'
    t.test_files = ENV['KNAPSACK_MINITEST_TEST_FILES'].to_s.split(' ')
  end

  task :minitest, [:minitest_args] do |_, args|
    allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::MinitestAdapter).allocator

    puts
    puts 'Report tests:'
    puts allocator.report_node_tests
    puts
    puts 'Leftover tests:'
    puts allocator.leftover_node_tests
    puts

    cmd = %Q[TESTOPTS="#{args[:minitest_args]}" KNAPSACK_MINITEST_TEST_FILES="#{allocator.stringify_node_tests}" bundle exec rake knapsack:minitest_run]

    system(cmd)
    exit($?.exitstatus)
  end
end
