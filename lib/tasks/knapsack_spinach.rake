require 'knapsack'

namespace :knapsack do
  task :spinach, [:spinach_args] do |_, args|
    Knapsack::Runners::SpinachRunner.run(args[:spinach_args])
  end
end
