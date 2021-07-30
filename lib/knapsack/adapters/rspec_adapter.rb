module Knapsack
  module Adapters
    class RSpecAdapter < BaseAdapter
      TEST_DIR_PATTERN = 'spec/**{,/*/**}/*_spec.rb'
      REPORT_PATH = 'knapsack_rspec_report.json'

      def bind_time_tracker
        ::RSpec.configure do |config|
          config.prepend_before(:context) do
            Knapsack.tracker.start_timer
          end

          config.prepend_before(:each) do |example|
            Knapsack.tracker.test_path = RSpecAdapter.test_path(example)
          end

          config.append_after(:context) do
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

      def self.test_path(example)
        example_group =
          if Gem::Version.new(::RSpec::Core::Version::STRING) < Gem::Version.new('3.0.0')
            # support for an old RSpec 2.x version
            example.metadata
          else
            example.metadata[:example_group]
          end

        if defined?(::Turnip) && Gem::Version.new(::Turnip::VERSION) < Gem::Version.new('2.0.0')
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

        example_group[:file_path]
      end
    end

    # This is added to provide backwards compatibility
    class RspecAdapter < RSpecAdapter
    end
  end
end
