require 'rake'

module Knapsack
  class TaskLoader
    include ::Rake::DSL

    def load_tasks
      Dir.glob("#{Knapsack.root}/lib/tasks/*.rake").each { |r| import r }
    end
  end
end
