# See how to write hooks and plugins
# https://github.com/seattlerb/minitest/blob/master/lib/minitest/test.rb
module Knapsack
  module Adapters
    class MinitestAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'test/**/*_test.rb'
      REPORT_PATH = 'knapsack_minitest_report.json'
      @@parent_of_test_dir = nil

      def set_test_helper_path(file_path)
        @@test_dir_path = File.dirname(file_path)
        @@parent_of_test_dir = File.expand_path('../', @@test_dir_path)
      end

      module BindTimeTrackerMinitestPlugin
        def before_setup
          super

          Knapsack.tracker.test_path = MinitestAdapter.test_path(self.class, self)
          Knapsack.tracker.start_timer
        end

        def after_teardown
          Knapsack.tracker.stop_timer
          super
        end
      end

      def bind_time_tracker
        ::Minitest::Test.send(:include, BindTimeTrackerMinitestPlugin)

        ::Minitest.after_run do
          #::Kernel.at_exit do
          Knapsack.logger.info(Presenter.global_time)
          #end
        end
      end


      def bind_report_generator
        Minitest.after_run do
          #::Kernel.at_exit do
          Knapsack.report.save
          Knapsack.logger.info(Presenter.report_details)
          #end
        end
      end

      def bind_time_offset_warning
        Minitest.after_run do
          #::Kernel.at_exit do
          Knapsack.logger.warn(Presenter.time_offset_warning)
          #end
        end
      end

      def self.test_path(test_class, obj)
        test_file_name = ::KnapsackExt::String.underscore_and_drop_module(test_class)
        test_file_pattern = "#{@@test_dir_path}/**/#{test_file_name}.rb"
        test_path = Dir.glob(test_file_pattern).first

        test_path.gsub(@@parent_of_test_dir, '.')
      end
    end
  end
end
