module Knapsack
  module Adapters
    class RSpecAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'spec/**{,/*/**}/*_spec.rb'
      REPORT_PATH = 'knapsack_rspec_report.json'

      def bind_time_tracker
        ::RSpec.configure do |config|
          config.prepend_before(:each) do
            current_example_group =
              if ::RSpec.respond_to?(:current_example)
                ::RSpec.current_example.metadata[:example_group]
              else
                example.metadata
              end
            Knapsack.tracker.test_path = RSpecAdapter.test_path(current_example_group)
            Knapsack.tracker.start_timer
          end

          config.append_after(:each) do
            Knapsack.tracker.stop_timer
          end

          config.after(:suite) do
            Knapsack.logger.info(Presenter.global_time)
          end
        end
      end

      def bind_report_generator
        ::RSpec.configure do |config|
          config.after(:suite) do
            Knapsack.report.save
            Knapsack.logger.info(Presenter.report_details)
          end
        end
      end

      def bind_time_offset_warning
        ::RSpec.configure do |config|
          config.after(:suite) do
            Knapsack.logger.log(
              Presenter.time_offset_log_level,
              Presenter.time_offset_warning
            )
          end
        end
      end

      def self.test_path(example_group)
        original_example_group = example_group

        if defined?(Turnip) && Turnip::VERSION.to_i < 2
          unless example_group[:turnip]
            until example_group[:parent_example_group].nil?
              example_group = example_group[:parent_example_group]
            end
          end
        else
          until example_group[:parent_example_group].nil?
            example_group = example_group[:parent_example_group]
          end
        end

        require 'pry'; binding.pry
        slow_spec_list = ENV['SLOW_SPECS']&.split(',')&.flat_map { |spec| ["#{spec}[1:1]", "#{spec}[1:2]"] } || []
        if slow_spec_list.any? { |slow_file_with_group| slow_file_with_group =~ Regexp.new(example_group[:file_path].sub(/^\.\//, '')) }
          require 'pry'; binding.pry
          "#{example_group[:file_path]}[#{original_example_group[:scoped_id].split(':').first(2).join(':')}]"
        else
          example_group[:file_path]
        end
      end
    end

    # This is added to provide backwards compatibility
    class RspecAdapter < RSpecAdapter
    end
  end
end
