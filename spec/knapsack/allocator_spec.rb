describe Knapsack::Allocator do
  let(:args) do
    {
      ci_node_total: nil,
      ci_node_index: nil,
      spec_pattern: nil,
      report: nil
    }
  end
  let(:report_distributor) { instance_double(Knapsack::Distributors::ReportDistributor) }
  let(:leftover_distributor) { instance_double(Knapsack::Distributors::LeftoverDistributor) }
  let(:report_specs) { ['a_spec.rb', 'b_spec.rb'] }
  let(:leftover_specs) { ['c_spec.rb', 'd_spec.rb'] }
  let(:node_specs) { report_specs + leftover_specs }
  let(:allocator) { described_class.new(args) }

  before do
    expect(Knapsack::Distributors::ReportDistributor).to receive(:new).with(args).and_return(report_distributor)
    expect(Knapsack::Distributors::LeftoverDistributor).to receive(:new).with(args).and_return(leftover_distributor)
  end

  describe '#report_node_specs' do
    subject { allocator.report_node_specs }

    before do
      expect(report_distributor).to receive(:specs_for_current_node).and_return(report_specs)
    end

    it { should eql report_specs }
  end

  describe '#leftover_node_specs' do
    subject { allocator.leftover_node_specs }

    before do
      expect(leftover_distributor).to receive(:specs_for_current_node).and_return(leftover_specs)
    end

    it { should eql leftover_specs }
  end

  describe '#node_specs' do
    subject { allocator.node_specs }

    before do
      expect(report_distributor).to receive(:specs_for_current_node).and_return(report_specs)
      expect(leftover_distributor).to receive(:specs_for_current_node).and_return(leftover_specs)
    end

    it { should eql node_specs }
  end

  describe '#stringify_node_specs' do
    subject { allocator.stringify_node_specs }

    before do
      expect(report_distributor).to receive(:specs_for_current_node).and_return(report_specs)
      expect(leftover_distributor).to receive(:specs_for_current_node).and_return(leftover_specs)
    end

    it { should eql node_specs.join(' ') }
  end
end
