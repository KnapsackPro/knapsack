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

    it { expect(subject).to match 'gems/knapsack' }
  end

  describe '.load_tasks' do
    let(:task_loader) { instance_double(Knapsack::TaskLoader) }

    it do
      expect(Knapsack::TaskLoader).to receive(:new).and_return(task_loader)
      expect(task_loader).to receive(:load_tasks)
      described_class.load_tasks
    end
  end
end
