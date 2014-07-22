describe Knapsack do
  describe '.tracker' do
    subject { described_class.tracker }

    it { should be_a Knapsack::Tracker }
    it { expect(subject.object_id).to eql described_class.tracker.object_id }
  end

  describe '.report' do
    subject { described_class.report }

    it { should be_a Knapsack::Report }
    it { expect(subject.object_id).to eql described_class.report.object_id }
  end

  describe '.root' do
    subject { described_class.root }

    it { expect(subject).to match 'knapsack' }
  end

  describe '.load_tasks' do
    let(:task_loader) { instance_double(Knapsack::TaskLoader) }

    it do
      expect(Knapsack::TaskLoader).to receive(:new).and_return(task_loader)
      expect(task_loader).to receive(:load_tasks)
      described_class.load_tasks
    end
  end

  describe '.logger' do
    subject { described_class.logger }

    before { described_class.logger = nil }
    after  { described_class.logger = nil }

    context 'when default logger' do
      let(:logger) { instance_double(Knapsack::Logger) }

      before do
        expect(Knapsack::Logger).to receive(:new).and_return(logger)
        expect(logger).to receive(:level=).with(Knapsack::Logger::INFO)
      end

      it { should eql logger }
    end

    context 'when custom logger' do
      let(:logger) { double('custom logger') }

      before do
        described_class.logger = logger
      end

      it { should eql logger }
    end
  end
end
