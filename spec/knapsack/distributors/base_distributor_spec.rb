describe Knapsack::Distributors::BaseDistributor do
  let(:args) { {} }
  let(:default_report) { { 'default_report_spec.rb' => 1.0 } }

  let(:distributor) { described_class.new(args) }

  before do
    allow(Knapsack).to receive(:report) {
      instance_double(Knapsack::Report, open: default_report)
    }
  end

  describe '#report' do
    subject { distributor.report }

    context 'when report is given' do
      let(:report) { { 'a_spec.rb' => 2.0 } }
      let(:args) { { report: report } }

      it { should eql(report) }
    end

    context 'when report is not given' do
      it { should eql(default_report) }
    end
  end

  describe '#ci_node_total' do
    subject { distributor.ci_node_total }

    context 'when ci_node_total is given' do
      let(:args) { { ci_node_total: 4 } }

      it { should eql 4 }
    end

    context 'when ci_node_total is not given' do
      it { should eql 1 }
    end
  end

  describe '#ci_node_index' do
    subject { distributor.ci_node_index }

    context 'when ci_node_index is given' do
      let(:args) { { ci_node_index: 3 } }

      it { should eql 3 }
    end

    context 'when ci_node_index is not given' do
      it { should eql 0 }
    end
  end

  describe '#specs_for_current_node' do
    let(:args) do
      {
        ci_node_total: 3,
        ci_node_index: ci_node_index
      }
    end
    let(:specs) { double }

    subject { distributor.specs_for_current_node }

    context 'when ci_node_index not set' do
      let(:ci_node_index) { nil }

      it do
        expect(distributor).to receive(:specs_for_node).with(0).and_return(specs)
        expect(subject).to eql specs
      end
    end

    context 'when ci_node_index set' do
      let(:ci_node_index) { 2 }

      it do
        expect(distributor).to receive(:specs_for_node).with(ci_node_index).and_return(specs)
        expect(subject).to eql specs
      end
    end
  end
end
