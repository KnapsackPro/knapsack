require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args] do |_, args|
    Knapsack::Runners::RSpecRunner.run(args[:rspec_args])
  end
end
