describe Knapsack::Config::Env do
  describe '.report_path' do
    subject { described_class.report_path }

    context 'when ENV exists' do
      let(:report_path) { 'knapsack_custom_report.json' }
      before { stub_const("ENV", { 'KNAPSACK_REPORT_PATH' => report_path }) }
      it { should eql report_path }
    end

    context "when ENV doesn't exist" do
      it { should be_nil }
    end
  end

  describe '.ci_node_total' do
    subject { described_class.ci_node_total }

    context 'when ENV exists' do
      context 'when CI_NODE_TOTAL has value' do
        before { stub_const("ENV", { 'CI_NODE_TOTAL' => 5 }) }
        it { should eql 5 }
      end

      context 'when CIRCLE_NODE_TOTAL has value' do
        before { stub_const("ENV", { 'CIRCLE_NODE_TOTAL' => 4 }) }
        it { should eql 4 }
      end

      context 'when SEMAPHORE_THREAD_COUNT has value' do
        before { stub_const("ENV", { 'SEMAPHORE_THREAD_COUNT' => 3 }) }
        it { should eql 3 }
      end

      context 'when BUILDKITE_PARALLEL_JOB_COUNT has value' do
        before { stub_const("ENV", { 'BUILDKITE_PARALLEL_JOB_COUNT' => 4 }) }
        it { should eql 4 }
      end
    end

    context "when ENV doesn't exist" do
      it { should eql 1 }
    end
  end

  describe '.ci_node_index' do
    subject { described_class.ci_node_index }

    context 'when ENV exists' do
      context 'when CI_NODE_INDEX has value' do
        before { stub_const("ENV", { 'CI_NODE_INDEX' => 3 }) }
        it { should eql 3 }
      end

      context 'when CIRCLE_NODE_INDEX has value' do
        before { stub_const("ENV", { 'CIRCLE_NODE_INDEX' => 2 }) }
        it { should eql 2 }
      end

      context 'when SEMAPHORE_CURRENT_THREAD has value' do
        before { stub_const("ENV", { 'SEMAPHORE_CURRENT_THREAD' => 1 }) }
        it { should eql 0 }
      end

      context 'when BUILDKITE_PARALLEL_JOB has value' do
        before { stub_const("ENV", { 'BUILDKITE_PARALLEL_JOB' => 2 }) }
        it { should eql 2 }
      end
    end

    context "when ENV doesn't exist" do
      it { should eql 0 }
    end
  end

  describe '.test_file_pattern' do
    subject { described_class.test_file_pattern }

    context 'when ENV exists' do
      let(:test_file_pattern) { 'custom_spec/**/*_spec.rb' }
      before { stub_const("ENV", { 'KNAPSACK_TEST_FILE_PATTERN' => test_file_pattern }) }
      it { should eql test_file_pattern }
    end

    context "when ENV doesn't exist" do
      it { should be_nil }
    end
  end
end
