describe Knapsack::Adapters::BaseAdapter do
  describe '.bind' do
    let(:adapter) { instance_double(described_class) }

    subject { described_class.bind }

    before do
      expect(described_class).to receive(:new).and_return(adapter)
      expect(adapter).to receive(:bind)
    end

    it { should eql adapter }
  end

  describe '#bind' do
    let(:tracker) { instance_double(Knapsack::Tracker) }

    before do
      allow(subject).to receive(:tracker).and_return(tracker)
    end

    context 'when generate report' do
      before do
        expect(tracker).to receive(:generate_report?).and_return(true)
      end

      it do
        expect(subject).to receive(:bind_time_tracker)
        expect(subject).to receive(:bind_report_generator)
        expect(subject).not_to receive(:bind_time_offset_warning)
        subject.bind
      end
    end

    context 'when enable time offset warning' do
      before do
        expect(tracker).to receive(:generate_report?).and_return(false)
        expect(tracker).to receive(:config).and_return({ enable_time_offset_warning: true })
      end

      it do
        expect(subject).to receive(:bind_time_tracker)
        expect(subject).to receive(:bind_time_offset_warning)
        expect(subject).not_to receive(:bind_report_generator)
        subject.bind
      end
    end

    context 'when adapter is off' do
      before do
        expect(tracker).to receive(:generate_report?).and_return(false)
        expect(tracker).to receive(:config).and_return({ enable_time_offset_warning: false })
      end

      it do
        expect(subject).not_to receive(:bind_time_tracker)
        expect(subject).not_to receive(:bind_report_generator)
        expect(subject).not_to receive(:bind_time_offset_warning)
        subject.bind
      end
    end
  end

  describe '#bind_time_tracker' do
    it do
      expect {
        subject.bind_time_tracker
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#bind_report_generator' do
    it do
      expect {
        subject.bind_report_generator
      }.to raise_error(NotImplementedError)
    end
  end

  describe '#bind_time_offset_warning' do
    it do
      expect {
        subject.bind_time_offset_warning
      }.to raise_error(NotImplementedError)
    end
  end
end
