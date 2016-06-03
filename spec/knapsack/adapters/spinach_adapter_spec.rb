describe Knapsack::Adapters::SpinachAdapter do
  context do
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
      let(:test_path) { 'features/a.feature' }
      let(:global_time) { 'Global time: 01m 05s' }
      let(:scenario_data) do
        double(feature: double(filename: test_path))
      end

      it do
        allow(Knapsack).to receive(:tracker).and_return(tracker)

        expect(Spinach.hooks).to receive(:before_scenario).and_yield(scenario_data, nil)
        expect(described_class).to receive(:test_path).with(scenario_data).and_return(test_path)
        expect(tracker).to receive(:test_path=).with(test_path)
        expect(tracker).to receive(:start_timer)

        expect(Spinach.hooks).to receive(:after_scenario).and_yield
        expect(tracker).to receive(:stop_timer)

        expect(Spinach.hooks).to receive(:after_run).and_yield
        expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
        expect(logger).to receive(:info).with(global_time)

        subject.bind_time_tracker
      end
    end

    describe '#bind_report_generator' do
      let(:report) { instance_double(Knapsack::Report) }
      let(:report_details) { 'Report details' }

      it do
        expect(Spinach.hooks).to receive(:after_run).and_yield

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

      it do
        expect(Spinach.hooks).to receive(:after_run).and_yield

        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)
        expect(Knapsack::Presenter).to receive(:time_offset_log_level).and_return(log_level)
        expect(logger).to receive(:log).with(log_level, time_offset_warning)

        subject.bind_time_offset_warning
      end
    end
  end

  describe '.test_path' do
    let(:scenario_data) do
      double(feature: double(filename: 'a.feature'))
    end

    subject { described_class.test_path(scenario_data) }

    it { should eql 'a.feature' }
  end
end
