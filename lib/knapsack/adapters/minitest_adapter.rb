module Knapsack
  module Adapters
    class MinitestAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'test/**/*_test.rb'
      REPORT_PATH = 'knapsack_minitest_report.json'
      @@parent_of_test_dir = nil

      # See how to write hooks and plugins
      # https://github.com/seattlerb/minitest/blob/master/lib/minitest/test.rb
      module BindTimeTrackerMinitestPlugin
        def before_setup
          super
          Knapsack.tracker.test_path = MinitestAdapter.test_path(self)
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
          Knapsack.logger.info(Presenter.global_time)
        end
      end


      def bind_report_generator
        Minitest.after_run do
          Knapsack.report.save
          Knapsack.logger.info(Presenter.report_details)
        end
      end

      def bind_time_offset_warning
        Minitest.after_run do
          Knapsack.logger.warn(Presenter.time_offset_warning)
        end
      end

      def set_test_helper_path(file_path)
        test_dir_path = File.dirname(file_path)
        @@parent_of_test_dir = File.expand_path('../', test_dir_path)
      end

      def self.test_path(obj)
        test_method_name = obj.name
        method_object = obj.method(test_method_name)
        full_test_path = method_object.source_location.first
        parent_of_test_dir_regexp = Regexp.new("^#{@@parent_of_test_dir}")
        test_path = full_test_path.gsub(parent_of_test_dir_regexp, '.')
        # test_path will look like ./test/dir/unit_test.rb
        test_path
      end
    end
  end
end
