describe Knapsack::Adapters::CucumberAdapter do
  context do
    context 'when Cucumber version 1' do
      before do
        stub_const('Cucumber::VERSION', '1.3.20')
        allow(::Cucumber::RbSupport::RbDsl).to receive(:register_rb_hook)
        allow(Kernel).to receive(:at_exit)
      end

      it_behaves_like 'adapter'
    end

    context 'when Cucumber version 2' do
      before do
        stub_const('Cucumber::VERSION', '2')
        allow(::Cucumber::RbSupport::RbDsl).to receive(:register_rb_hook)
        allow(Kernel).to receive(:at_exit)
      end

      it_behaves_like 'adapter'
    end

    context 'when Cucumber version 3' do
      before do
        stub_const('Cucumber::VERSION', '3.0.0')
        allow(::Cucumber::Glue::Dsl).to receive(:register_rb_hook)
        allow(Kernel).to receive(:at_exit)
      end

      it_behaves_like 'adapter'
    end
  end

  describe 'bind methods' do
    let(:logger) { instance_double(Knapsack::Logger) }

    before do
      allow(Knapsack).to receive(:logger).and_return(logger)
    end

    describe '#bind_time_tracker' do
      let(:file) { 'features/a.feature' }
      let(:block) { double }
      let(:global_time) { 'Global time: 01m 05s' }
      let(:tracker) { instance_double(Knapsack::Tracker) }

      context 'when Cucumber version 1' do
        let(:scenario) { double(file: file) }

        before { stub_const('Cucumber::VERSION', '1.3.20') }

        it do
          expect(subject).to receive(:Around).and_yield(scenario, block)
          allow(Knapsack).to receive(:tracker).and_return(tracker)
          expect(tracker).to receive(:test_path=).with(file)
          expect(tracker).to receive(:start_timer)
          expect(block).to receive(:call)
          expect(tracker).to receive(:stop_timer)

          expect(::Kernel).to receive(:at_exit).and_yield
          expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
          expect(logger).to receive(:info).with(global_time)

          subject.bind_time_tracker
        end
      end

      context 'when Cucumber version 2' do
        let(:test_case) { double(location: double(file: file)) }

        # complex version name to ensure we can catch that too
        before { stub_const('Cucumber::VERSION', '2.0.0.rc.5') }

        it do
          expect(subject).to receive(:Around).and_yield(test_case, block)
          allow(Knapsack).to receive(:tracker).and_return(tracker)
          expect(tracker).to receive(:test_path=).with(file)
          expect(tracker).to receive(:start_timer)
          expect(block).to receive(:call)
          expect(tracker).to receive(:stop_timer)

          expect(::Kernel).to receive(:at_exit).and_yield
          expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
          expect(logger).to receive(:info).with(global_time)

          subject.bind_time_tracker
        end
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
      let(:log_level) { :info }

      it 'creates an at-exit callback to log the time offset message at the specified log level' do
        expect(::Kernel).to receive(:at_exit).and_yield
        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)
        expect(Knapsack::Presenter).to receive(:time_offset_log_level).and_return(log_level)
        expect(logger).to receive(:log).with(log_level, time_offset_warning)

        subject.bind_time_offset_warning
      end
    end
  end

  describe '.test_path' do
    context 'when Cucumber version 1' do
      subject { described_class.test_path(scenario_or_outline_table) }

      before { stub_const('Cucumber::VERSION', '1') }

      context 'when cucumber >= 1.3' do
        context 'when scenario' do
          let(:scenario_file) { 'features/scenario.feature' }
          let(:scenario_or_outline_table) { double(file: scenario_file) }

          it { should eql scenario_file }
        end

        context 'when scenario outline' do
          let(:scenario_outline_file) { 'features/scenario_outline.feature' }
          let(:scenario_or_outline_table) do
            double(scenario_outline: double(file: scenario_outline_file))
          end

          it { should eql scenario_outline_file }
        end
      end

      context 'when cucumber < 1.3' do
        context 'when scenario' do
          let(:scenario_file) { 'features/scenario.feature' }
          let(:scenario_or_outline_table) { double(feature: double(file: scenario_file)) }

          it { should eql scenario_file }
        end

        context 'when scenario outline' do
          let(:scenario_outline_file) { 'features/scenario_outline.feature' }
          let(:scenario_or_outline_table) do
            double(scenario_outline: double(feature: double(file: scenario_outline_file)))
          end

          it { should eql scenario_outline_file }
        end
      end
    end

    context 'when Cucumber version 2' do
      let(:file) { 'features/a.feature' }
      let(:test_case) { double(location: double(file: file)) } # Cucumber 2

      subject { described_class.test_path(test_case) }

      before { stub_const('Cucumber::VERSION', '2') }

      it { should eql file }
    end
  end
end
