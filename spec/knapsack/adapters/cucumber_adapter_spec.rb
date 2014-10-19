describe Knapsack::Adapters::CucumberAdapter do
  context do
    before do
      allow(::Cucumber::RbSupport::RbDsl).to receive(:register_rb_hook)
      allow(Kernel).to receive(:at_exit)
    end

    it_behaves_like 'adapter'
  end

  describe 'bind methods' do
    let(:file) { 'features/a.feature' }
    let(:scenario) { double(file: file) }
    let(:block) { double }
    let(:logger) { instance_double(Knapsack::Logger) }
    let(:global_time) { 'Global time: 01m 05s' }

    before do
      expect(Knapsack).to receive(:logger).and_return(logger)
    end

    describe '#bind_time_tracker' do
      let(:tracker) { instance_double(Knapsack::Tracker) }

      it do
        expect(subject).to receive(:Around).and_yield(scenario, block)
        allow(Knapsack).to receive(:tracker).and_return(tracker)
        expect(tracker).to receive(:spec_path=).with(file)
        expect(tracker).to receive(:start_timer)
        expect(block).to receive(:call)
        expect(tracker).to receive(:stop_timer)

        expect(::Kernel).to receive(:at_exit).and_yield
        expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
        expect(logger).to receive(:info).with(global_time)

        subject.bind_time_tracker
      end
    end

    describe '#bind_report_generator' do
      let(:report) { instance_double(Knapsack::Report) }
      let(:report_details) { 'Report details' }

      it do
        expect(::Kernel).to receive(:at_exit).and_yield
        expect(Knapsack).to receive(:report).and_return(report)
        expect(report).to receive(:save)

        expect(Knapsack::Presenter).to receive(:report_details).and_return(report_details)
        expect(logger).to receive(:info).with(report_details)

        subject.bind_report_generator
      end
    end

    describe '#bind_time_offset_warning' do
      let(:time_offset_warning) { 'Time offset warning' }

      it do
        expect(::Kernel).to receive(:at_exit).and_yield
        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)
        expect(logger).to receive(:warn).with(time_offset_warning)

        subject.bind_time_offset_warning
      end
    end
  end
end
