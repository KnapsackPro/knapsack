require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args, :folders_to_ignore] do |_, args|
    args.with_defaults(:folders_to_ignore => '')
    Knapsack::Runners::RSpecRunner.run(args[:rspec_args], args[:folders_to_ignore])
  end
end
