module Knapsack
  module Runners
    class RSpecRunner
      def self.run(args, folders, knapsack_flags)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::RSpecAdapter).allocator

        unless flag_included?(knapsack_flags, 'quiet')
          Knapsack.logger.info
          Knapsack.logger.info 'Report specs:'
          Knapsack.logger.info allocator.report_node_tests
          Knapsack.logger.info
          Knapsack.logger.info 'Leftover specs:'
          Knapsack.logger.info allocator.leftover_node_tests
          Knapsack.logger.info
        end

        node_tests = filter_excluded_folders(allocator.stringify_node_tests, folders)

        cmd = %Q[bundle exec rspec #{args} --default-path #{allocator.test_dir} -- #{node_tests}]

        exec(cmd)
      end

      def self.filter_excluded_folders(node_tests, folders)
        return node_tests if folders.blank?

        files = node_tests.split(" ")
        folders_to_ignore = folders.split('|')

        filtered_files = files.reject do |file|
          folders_to_ignore.any? { |folder| file.include?(folder) }
        end

        tests_to_run = filtered_files.join(' ')
      end

      def self.flag_included?(knapsack_flags, flag_to_validate)
        knapsack_flags.split('|').include?(flag_to_validate)
      end
    end
  end
end