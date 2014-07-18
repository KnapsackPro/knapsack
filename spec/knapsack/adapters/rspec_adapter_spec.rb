describe Knapsack::Adapters::RspecAdapter do
  it_behaves_like 'adapter'

  describe 'bind methods' do
    let(:config) { double }

    describe '#bind_time_tracker' do
      let(:tracker) { instance_double(Knapsack::Tracker) }
      let(:spec_path) { 'spec/a_spec.rb' }
      let(:global_time) { 'Global time: 01m 05s' }

      it do
        expect(described_class).to receive(:spec_path).and_return(spec_path)

        allow(Knapsack).to receive(:tracker).and_return(tracker)
        expect(tracker).to receive(:spec_path=).with(spec_path)
        expect(tracker).to receive(:start_timer)
        expect(tracker).to receive(:stop_timer)

        expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)

        expect(config).to receive(:before).with(:each).and_yield
        expect(config).to receive(:after).with(:each).and_yield
        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect {
          subject.bind_time_tracker
        }.to output(/#{global_time}/).to_stdout
      end
    end

    describe '#bind_report_generator' do
      let(:report) { instance_double(Knapsack::Report) }
      let(:report_details) { 'Report details' }

      it do
        expect(Knapsack).to receive(:report).and_return(report)
        expect(report).to receive(:save)

        expect(Knapsack::Presenter).to receive(:report_details).and_return(report_details)

        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect {
          subject.bind_report_generator
        }.to output(/#{report_details}/).to_stdout
      end
    end

    describe '#bind_time_offset_warning' do
      let(:time_offset_warning) { 'Time offset warning' }

      it do
        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)

        expect(config).to receive(:after).with(:suite).and_yield
        expect(::RSpec).to receive(:configure).and_yield(config)

        expect {
          subject.bind_time_offset_warning
        }.to output(/#{time_offset_warning}/).to_stdout
      end
    end
  end
end
