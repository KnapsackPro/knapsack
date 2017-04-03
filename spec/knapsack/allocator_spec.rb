describe Knapsack::Allocator do
  let(:test_file_pattern) { nil }
  let(:args) do
    {
      ci_node_total: nil,
      ci_node_index: nil,
      test_file_pattern: test_file_pattern,
      report: nil
    }
  end
  let(:report_distributor) { instance_double(Knapsack::Distributors::ReportDistributor) }
  let(:leftover_distributor) { instance_double(Knapsack::Distributors::LeftoverDistributor) }
  let(:report_tests) { ['a_spec.rb', 'b_spec.rb'] }
  let(:leftover_tests) { ['c_spec.rb', 'd_spec.rb'] }
  let(:node_tests) { report_tests + leftover_tests }
  let(:allocator) { described_class.new(args) }

  before do
    expect(Knapsack::Distributors::ReportDistributor).to receive(:new).with(args).and_return(report_distributor)
    expect(Knapsack::Distributors::LeftoverDistributor).to receive(:new).with(args).and_return(leftover_distributor)
    allow(report_distributor).to receive(:tests_for_current_node).and_return(report_tests)
    allow(leftover_distributor).to receive(:tests_for_current_node).and_return(leftover_tests)
  end

  describe '#report_node_tests' do
    subject { allocator.report_node_tests }
    it { should eql report_tests }
  end

  describe '#leftover_node_tests' do
    subject { allocator.leftover_node_tests }
    it { should eql leftover_tests }
  end

  describe '#node_tests' do
    subject { allocator.node_tests }
    it { should eql node_tests }
  end

  describe '#stringify_node_tests' do
    subject { allocator.stringify_node_tests }
    it { should eql %{"a_spec.rb" "b_spec.rb" "c_spec.rb" "d_spec.rb"} }
  end

  describe '#test_dir' do
    subject { allocator.test_dir }

    context 'when ENV test_dir has value' do
      let(:test_dir) { "custom_dir" }

      before do
        expect(Knapsack::Config::Env).to receive(:test_dir).and_return(test_dir)
      end

      it { should eql 'custom_dir' }
    end

    context 'when ENV test_dir has no value' do
      let(:test_file_pattern) { "test_dir/**{,/*/**}/*_spec.rb" }

      before do
        expect(report_distributor).to receive(:test_file_pattern).and_return(test_file_pattern)
      end

      it { should eql 'test_dir' }
    end
  end
end
