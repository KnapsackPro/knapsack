describe Knapsack::TaskLoader do
  describe '#load_tasks' do
    let(:rspec_rake_task_path) { "#{Knapsack.root}/lib/tasks/knapsack_rspec.rake" }
    let(:cucumber_rake_task_path) { "#{Knapsack.root}/lib/tasks/knapsack_cucumber.rake" }
    let(:minitest_rake_task_path) { "#{Knapsack.root}/lib/tasks/knapsack_minitest.rake" }

    it do
      expect(subject).to receive(:import).with(rspec_rake_task_path)
      expect(subject).to receive(:import).with(cucumber_rake_task_path)
      expect(subject).to receive(:import).with(minitest_rake_task_path)
      subject.load_tasks
    end
  end
end
