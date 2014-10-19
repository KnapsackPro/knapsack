describe Knapsack::Distributors::LeftoverDistributor do
  let(:report) do
    {
      'a_spec.rb' => 1.0,
      'b_spec.rb' => 1.5,
      'c_spec.rb' => 2.0,
      'd_spec.rb' => 2.5,
    }
  end
  let(:spec_pattern) { 'spec/**/*_spec.rb' }
  let(:default_args) do
    {
      report: report,
      spec_pattern: spec_pattern,
      ci_node_total: '1',
      ci_node_index: '0'
    }
  end
  let(:args) { default_args.merge(custom_args) }
  let(:custom_args) { {} }
  let(:distributor) { described_class.new(args) }

  describe '#report_specs' do
    subject { distributor.report_specs }
    it { should eql ['a_spec.rb', 'b_spec.rb', 'c_spec.rb', 'd_spec.rb'] }
  end

  describe '#all_specs' do
    subject { distributor.all_specs }

    context 'when given spec pattern' do
      context 'spec/**/*_spec.rb' do
        it { should_not be_empty }
        it { should include 'spec/knapsack/tracker_spec.rb' }
        it { should include 'spec/knapsack/adapters/rspec_adapter_spec.rb' }
      end

      context 'spec_examples/**/*_spec.rb' do
        let(:spec_pattern) { 'spec_examples/**/*_spec.rb' }

        it { should_not be_empty }
        it { should include 'spec_examples/fast/1_spec.rb' }
        it { should include 'spec_examples/leftover/a_spec.rb' }
      end
    end

    context 'when fake spec pattern' do
      let(:spec_pattern) { 'fake_pattern' }
      it { should be_empty }
    end

    context 'when missing spec pattern' do
      let(:spec_pattern) { nil }
      it { expect { subject }.to raise_error('Missing spec_pattern') }
    end
  end

  describe '#leftover_specs' do
    subject { distributor.leftover_specs }

    before do
      expect(distributor).to receive(:all_specs).and_return([
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

  context do
    let(:custom_args) { { ci_node_total: 3 } }
    let(:leftover_specs) {[
      'a_spec.rb',
      'b_spec.rb',
      'c_spec.rb',
      'd_spec.rb',
      'e_spec.rb',
      'f_spec.rb',
      'g_spec.rb',
    ]}

    before do
      expect(distributor).to receive(:leftover_specs).and_return(leftover_specs)
    end

    describe '#assign_spec_files_to_node' do
      before do
        distributor.assign_spec_files_to_node
      end

      it do
        expect(distributor.node_specs[0]).to eql([
          'a_spec.rb',
          'd_spec.rb',
          'g_spec.rb',
        ])
      end

      it do
        expect(distributor.node_specs[1]).to eql([
          'b_spec.rb',
          'e_spec.rb',
        ])
      end

      it do
        expect(distributor.node_specs[2]).to eql([
          'c_spec.rb',
          'f_spec.rb',
        ])
      end
    end

    describe '#specs_for_node' do
      it do
        expect(distributor.specs_for_node(1)).to eql([
          'b_spec.rb',
          'e_spec.rb',
        ])
      end
    end
  end
end
