require 'bundler/gem_tasks'
require 'rake/testtask'
require 'knapsack'

Knapsack.load_tasks

Rake::TestTask.new(:test) do |t|
  t.libs << 'test_examples'
  t.pattern = 'test_examples/**{,/*/**}/*_test.rb'
end
