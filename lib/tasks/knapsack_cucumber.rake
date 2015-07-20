require 'knapsack'

namespace :knapsack do
  task :cucumber, [:cucumber_args] do |_, args|
    Knapsack::Runners::CucumberRunner.run(args[:cucumber_args])
  end
end
