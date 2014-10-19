describe Knapsack::AllocatorBuilder do
  let(:allocator_builder) { described_class.new(adapter_class) }
  let(:allocator) { double }

  let(:report) { double }
  let(:knapsack_report) { instance_double(Knapsack::Report) }

  let(:adapter_report_path) { adapter_class::REPORT_PATH }
  let(:adapter_test_file_pattern) { adapter_class::TEST_DIR_PATTERN }

  let(:env_ci_node_total) { double }
  let(:env_ci_node_index) { double }
  let(:env_report_path) { nil }
  let(:env_test_file_pattern) { nil }

  describe '#allocator' do
    subject { allocator_builder.allocator }

    before do
      expect(Knapsack::Config::Env).to receive(:report_path).and_return(env_report_path)
      expect(Knapsack::Config::Env).to receive(:test_file_pattern).and_return(env_test_file_pattern)
      expect(Knapsack::Config::Env).to receive(:ci_node_total).and_return(env_ci_node_total)
      expect(Knapsack::Config::Env).to receive(:ci_node_index).and_return(env_ci_node_index)

      expect(Knapsack).to receive(:report).twice.and_return(knapsack_report)
      expect(knapsack_report).to receive(:open).and_return(report)

      expect(knapsack_report).to receive(:config).with(report_config)
      expect(Knapsack::Allocator).to receive(:new).with(allocator_args).and_return(allocator)
    end

    shared_examples 'allocator builder' do
      context 'when ENVs are nil' do
        let(:report_config) { { report_path: adapter_report_path } }
        let(:allocator_args) do
          {
            report: report,
            test_file_pattern: adapter_test_file_pattern,
            ci_node_total: env_ci_node_total,
            ci_node_index: env_ci_node_index
          }
        end

        it { should eql allocator }
      end

      context 'when ENV report_path has value' do
        let(:env_report_path) { 'knapsack_custom_report.json' }
        let(:report_config) { { report_path: env_report_path } }
        let(:allocator_args) do
          {
            report: report,
            test_file_pattern: adapter_test_file_pattern,
            ci_node_total: env_ci_node_total,
            ci_node_index: env_ci_node_index
          }
        end

        it { should eql allocator }
      end

      context 'when ENV test_file_pattern has value' do
        let(:env_test_file_pattern) { 'custom_spec/**/*_spec.rb' }
        let(:report_config) { { report_path: adapter_report_path } }
        let(:allocator_args) do
          {
            report: report,
            test_file_pattern: env_test_file_pattern,
            ci_node_total: env_ci_node_total,
            ci_node_index: env_ci_node_index
          }
        end

        it { should eql allocator }
      end
    end

    context 'when RspecAdapter' do
      let(:adapter_class) { Knapsack::Adapters::RspecAdapter }
      it_behaves_like 'allocator builder'
    end

    context 'when CucumberAdapter' do
      let(:adapter_class) { Knapsack::Adapters::CucumberAdapter }
      it_behaves_like 'allocator builder'
    end
  end
end
