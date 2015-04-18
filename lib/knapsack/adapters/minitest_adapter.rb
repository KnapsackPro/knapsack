# See how to write hooks and plugins
# https://github.com/seattlerb/minitest/blob/master/lib/minitest/test.rb
module Knapsack
  module Adapters
    class MinitestAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'test/**/*_test.rb'
      REPORT_PATH = 'knapsack_minitest_report.json'

      module BindTimeTrackerMinitestPlugin
        def before_setup
          super
          #require 'pry'; binding.pry
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
          #::Kernel.at_exit do
          Knapsack.logger.info(Presenter.global_time)
          #end
        end

        #class ::MiniTest::Test
          #include BindTimeTrackerMinitestPlugin
        #end
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

      def self.test_path(obj)
        # FIXME should return path to the file that contains particular test
        'test_a'
      end
    end
  end
end
