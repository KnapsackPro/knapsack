describe Knapsack::Adapters::RSpecAdapter do
  context do
    before { expect(::RSpec).to receive(:configure) }
    it_behaves_like 'adapter'
  end

  describe 'bind methods' do
    let(:config) { double }
    let(:logger) { instance_double(Knapsack::Logger) }

    before do
      expect(Knapsack).to receive(:logger).and_return(logger)
    end

    describe '#bind_time_tracker' do
      let(:tracker) { instance_double(Knapsack::Tracker) }
      let(:test_path) { 'spec/a_spec.rb' }
      let(:global_time) { 'Global time: 01m 05s' }
      let(:current_example) { double }

      it do
        expect(config).to receive(:prepend_before).with(:context).and_yield
        expect(config).to receive(:prepend_before).with(:each).and_yield(current_example)
        expect(config).to receive(:append_after).with(:context).and_yield
        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect(described_class).to receive(:test_path).with(current_example).and_return(test_path)

        allow(Knapsack).to receive(:tracker).and_return(tracker)
        expect(tracker).to receive(:start_timer).ordered
        expect(tracker).to receive(:test_path=).with(test_path).ordered
        expect(tracker).to receive(:stop_timer).ordered

        expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
        expect(logger).to receive(:info).with(global_time)

        subject.bind_time_tracker
      end
    end

    describe '#bind_report_generator' do
      let(:report) { instance_double(Knapsack::Report) }
      let(:report_details) { 'Report details' }

      it do
        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect(Knapsack).to receive(:report).and_return(report)
        expect(report).to receive(:save)

        expect(Knapsack::Presenter).to receive(:report_details).and_return(report_details)
        expect(logger).to receive(:info).with(report_details)

        subject.bind_report_generator
      end
    end

    describe '#bind_time_offset_warning' do
      let(:time_offset_warning) { 'Time offset warning' }
      let(:log_level) { :info }

      it 'creates a post-suite callback to log the time offset message at the specified log level' do
        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)
        expect(Knapsack::Presenter).to receive(:time_offset_log_level).and_return(log_level)
        expect(logger).to receive(:log).with(log_level, time_offset_warning)

        subject.bind_time_offset_warning
      end
    end
  end

  describe '.test_path' do
    let(:example_group) do
      {
          file_path: '1_shared_example.rb',
          parent_example_group: {
            file_path: '2_shared_example.rb',
            parent_example_group: {
              file_path: 'a_spec.rb'
            }
          }
      }
    end
    let(:current_example) do
      OpenStruct.new(metadata: {
        example_group: example_group
      })
    end

    subject { described_class.test_path(current_example) }

    it { should eql 'a_spec.rb' }

    context 'with turnip features' do
      describe 'when the turnip version is less than 2' do
        let(:example_group) do
          {
            file_path: "./spec/features/logging_in.feature",
            turnip: true,
            parent_example_group: {
              file_path: "gems/turnip-1.2.4/lib/turnip/rspec.rb"
            }
          }
        end

        before { stub_const("Turnip::VERSION", '1.2.4') }

        it { should eql './spec/features/logging_in.feature' }
      end

      describe 'when turnip is version 2 or greater' do
        let(:example_group) do
          {
            file_path: "gems/turnip-2.0.0/lib/turnip/rspec.rb",
            turnip: true,
            parent_example_group: {
              file_path: "./spec/features/logging_in.feature",
            }
          }
        end

        before { stub_const("Turnip::VERSION",  '2.0.0') }

        it { should eql './spec/features/logging_in.feature' }
      end
    end
  end
end
