describe Knapsack::Distributors::LeftoverDistributor do
  let(:args) { {} }
  let(:default_report) do
    {
      'a_spec.rb' => 1.0,
      'b_spec.rb' => 1.5,
      'c_spec.rb' => 2.0,
      'd_spec.rb' => 2.5,
    }
  end

  let(:leftover_distributor) { described_class.new(args) }

  before do
    allow(Knapsack).to receive(:report) {
      instance_double(Knapsack::Report, open: default_report)
    }
  end

  describe '#report_specs' do
    subject { leftover_distributor.report_specs }
    it { should eql ['a_spec.rb', 'b_spec.rb', 'c_spec.rb', 'd_spec.rb'] }
  end

  describe '#all_specs' do
    subject { leftover_distributor.all_specs }

    context 'when default spec pattern' do
      it { should_not be_empty }
      it { should include 'spec/knapsack/tracker_spec.rb' }
      it { should include 'spec/knapsack/adapters/rspec_spec.rb' }
    end

    context 'when fake spec pattern' do
      let(:args) { { spec_pattern: 'fake_pattern' } }
      it { should be_empty }
    end
  end

  describe '#leftover_specs' do
    subject { leftover_distributor.leftover_specs }

    before do
      expect(leftover_distributor).to receive(:all_specs).and_return([
      'a_spec.rb',
      'b_spec.rb',
      'c_spec.rb',
      'd_spec.rb',
      'e_spec.rb',
      'f_spec.rb',
      ])
    end

    it { should eql ['e_spec.rb', 'f_spec.rb'] }
  end
end
