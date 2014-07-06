describe Knapsack::Distributor do
  let(:args) { {} }
  let(:default_report) { { 'default_report_spec.rb' => 1.0 } }

  subject { described_class.new(args) }

  before do
    allow(Knapsack).to receive(:report) {
      instance_double(Knapsack::Report, open: default_report)
    }
  end

  describe '#report' do
    context 'when report is given' do
      let(:report) { { 'a_spec.rb' => 2.0 } }
      let(:args) { { report: report } }

      it { expect(subject.report).to eql(report) }
    end

    context 'when report is not given' do
      it { expect(subject.report).to eql(default_report) }
    end
  end

  describe '#ci_node_total' do
    context 'when env is given' do
      before { stub_const('ENV', {'CI_NODE_TOTAL' => 4}) }

      it { expect(subject.ci_node_total).to eql 4 }
    end

    context 'when env is not given' do
      it { expect(subject.ci_node_total).to eql 1 }
    end
  end

  describe '#ci_node_index' do
    context 'when env is given' do
      before { stub_const('ENV', {'CI_NODE_INDEX' => 3}) }

      it { expect(subject.ci_node_index).to eql 3 }
    end

    context 'when env is not given' do
      it { expect(subject.ci_node_index).to eql 0 }
    end
  end
end
