describe Knapsack::Allocator do
  let(:args) { {} }
  let(:report_distributor) { instance_double(Knapsack::Distributors::ReportDistributor) }
  let(:leftover_distributor) { instance_double(Knapsack::Distributors::LeftoverDistributor) }
  let(:specs) { double }
  let(:allocator) { described_class.new(args) }

  before do
    expect(Knapsack::Distributors::ReportDistributor).to receive(:new).with(args).and_return(report_distributor)
    expect(Knapsack::Distributors::LeftoverDistributor).to receive(:new).with(args).and_return(leftover_distributor)
  end

  describe '#report_node_specs' do
    subject { allocator.report_node_specs }

    before do
      expect(report_distributor).to receive(:specs_for_current_node).and_return(specs)
    end

    it { should eql specs }
  end
end
