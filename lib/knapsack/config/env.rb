module Knapsack
  module Config
    class Env
      class << self
        def report_path
          ENV['KNAPSACK_REPORT_PATH']
        end

        def ci_node_total
          ENV['CI_NODE_TOTAL'] || ENV['CIRCLE_NODE_TOTAL'] || ENV['SEMAPHORE_THREAD_COUNT'] || ENV['BUILDKITE_PARALLEL_JOB_COUNT'] || ENV['SNAP_WORKER_TOTAL'] || 1
        end

        def ci_node_index
          gitlab_ci_node_index || ENV['CI_NODE_INDEX'] || ENV['CIRCLE_NODE_INDEX'] || semaphore_current_thread || ENV['BUILDKITE_PARALLEL_JOB'] || snap_ci_worker_index || 0
        end

        def test_file_pattern
          ENV['KNAPSACK_TEST_FILE_PATTERN']
        end

        def test_dir
          ENV['KNAPSACK_TEST_DIR']
        end

        def log_level
          {
            "debug" => Knapsack::Logger::DEBUG,
            "info"  => Knapsack::Logger::INFO,
            "warn"  => Knapsack::Logger::WARN,
          }[ENV['KNAPSACK_LOG_LEVEL']] || Knapsack::Logger::INFO
        end

        private

        def index_starting_from_one(index)
          index.to_i - 1 if index
        end

        def semaphore_current_thread
          index_starting_from_one(ENV['SEMAPHORE_CURRENT_THREAD'])
        end

        def snap_ci_worker_index
          index_starting_from_one(ENV['SNAP_WORKER_INDEX'])
        end

        def gitlab_ci_node_index
          return unless ENV['GITLAB_CI']

          index_starting_from_one(ENV['CI_NODE_INDEX'])
        end
      end
    end
  end
end
