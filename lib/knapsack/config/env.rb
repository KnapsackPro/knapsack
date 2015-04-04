module Knapsack
  module Config
    class Env
      class << self
        def report_path
          ENV['KNAPSACK_REPORT_PATH']
        end

        def ci_node_total
          ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL'] || ENV['SEMAPHORE_THREAD_COUNT'] || ENV['BUILDKITE_PARALLEL_JOB_COUNT'] || 1
        end

        def ci_node_index
          ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX'] || semaphore_current_thread || ENV['BUILDKITE_PARALLEL_JOB'] || 0
        end

        def test_file_pattern
          ENV['KNAPSACK_TEST_FILE_PATTERN']
        end

        private

        def semaphore_current_thread
          index = ENV['SEMAPHORE_CURRENT_THREAD']
          index.to_i - 1 if index
        end
      end
    end
  end
end
