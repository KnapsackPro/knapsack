describe Knapsack::Distributors::BaseDistributor do
  let(:report) { { 'a_spec.rb' => 1.0 } }
  let(:default_args) do
    {
      report: report,
      test_file_pattern: 'spec/**{,/*/**}/*_spec.rb',
      ci_node_total: '1',
      ci_node_index: '0'
    }
  end
  let(:args) { default_args.merge(custom_args) }
  let(:custom_args) { {} }
  let(:distributor) { described_class.new(args) }

  describe '#report' do
    subject { distributor.report }

    context 'when report is given' do
      it { should eql(report) }
    end

    context 'when report is not given' do
      let(:custom_args) { { report: nil } }
      it { expect { subject }.to raise_error('Missing report') }
    end
  end

  describe '#ci_node_total' do
    subject { distributor.ci_node_total }

    context 'when ci_node_total is given' do
      it { should eql 1 }
    end

    context 'when ci_node_total is not given' do
      let(:custom_args) { { ci_node_total: nil } }
      it { expect { subject }.to raise_error('Missing ci_node_total') }
    end
  end

  describe '#ci_node_index' do
    subject { distributor.ci_node_index }

    context 'when ci_node_index is given' do
      it { should eql 0 }
    end

    context 'when ci_node_index is not given' do
      let(:custom_args) { { ci_node_index: nil } }
      it { expect { subject }.to raise_error('Missing ci_node_index') }
    end

    context 'when ci_node_index has not allowed value' do
      let(:expected_exception_message) do
        "Node indexes are 0-based. Can't be higher or equal to the total number of nodes."
      end

      context 'when ci_node_index is equal to ci_node_total' do
        let(:custom_args) { { ci_node_index: 1, ci_node_total: 1 } }
        it { expect { subject }.to raise_error(expected_exception_message) }
      end

      context 'when ci_node_index is higher than ci_node_total' do
        let(:custom_args) { { ci_node_index: 2, ci_node_total: 1 } }
        it { expect { subject }.to raise_error(expected_exception_message) }
      end
    end
  end

  describe '#tests_for_current_node' do
    let(:custom_args) do
      {
        ci_node_total: 3,
        ci_node_index: ci_node_index
      }
    end
    let(:ci_node_index) { 2 }
    let(:tests) { double }

    subject { distributor.tests_for_current_node }

    before do
      expect(distributor).to receive(:tests_for_node).with(ci_node_index).and_return(tests)
    end

    it { should eql tests }
  end
end
