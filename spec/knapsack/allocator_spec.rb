describe Knapsack::Allocator do
  let(:spec_pattern) { nil }
  let(:args) do
    {
      ci_node_total: nil,
      ci_node_index: nil,
      spec_pattern: spec_pattern,
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
    allow(report_distributor).to receive(:specs_for_current_node).and_return(report_specs)
    allow(leftover_distributor).to receive(:specs_for_current_node).and_return(leftover_specs)
  end

  describe '#report_node_specs' do
    subject { allocator.report_node_specs }
    it { should eql report_specs }
  end

  describe '#leftover_node_specs' do
    subject { allocator.leftover_node_specs }
    it { should eql leftover_specs }
  end

  describe '#node_specs' do
    subject { allocator.node_specs }
    it { should eql node_specs }
  end

  describe '#stringify_node_specs' do
    subject { allocator.stringify_node_specs }
    it { should eql node_specs.join(' ') }
  end

  describe '#custom_spec_dir' do
    subject { allocator.custom_spec_dir }

    context 'when spec pattern exists' do
      let(:spec_pattern) { "custom_spec_dir/**/*_spec.rb" }
      it { should eql 'custom_spec_dir/' }
    end

    context "when spec pattern doesn't exist" do
      it { should be_nil }
    end
  end
end
