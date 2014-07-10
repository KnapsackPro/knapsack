describe Knapsack::TaskLoader do
  describe '#load_tasks' do
    let(:rake_task_path) { "#{Knapsack.root}/lib/tasks/knapsack.rake" }

    it do
      expect(subject).to receive(:import).with(rake_task_path)
      subject.load_tasks
    end
  end
end
