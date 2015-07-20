require 'knapsack'

namespace :knapsack do
  task :minitest, [:minitest_args] do |_, args|
    Knapsack::Runners::MinitestRunner.run(args[:minitest_args])
  end
end
