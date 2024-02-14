require 'knapsack'

namespace :knapsack do
  task :rspec, [:rspec_args, :folders_to_ignore, :knapsack_flags] do |_, args|
    args.with_defaults(:folders_to_ignore => '', :knapsack_flags => '')
    Knapsack::Runners::RSpecRunner.run(args[:rspec_args], args[:folders_to_ignore], args[:knapsack_flags])
  end
end
