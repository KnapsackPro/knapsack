describe Knapsack::Distributors::LeftoverDistributor do
  let(:report) do
    {
      'a_spec.rb' => 1.0,
      'b_spec.rb' => 1.5,
      'c_spec.rb' => 2.0,
      'd_spec.rb' => 2.5,
    }
  end
  let(:test_file_pattern) { 'spec/**/*_spec.rb' }
  let(:default_args) do
    {
      report: report,
      test_file_pattern: test_file_pattern,
      ci_node_total: '1',
      ci_node_index: '0'
    }
  end
  let(:args) { default_args.merge(custom_args) }
  let(:custom_args) { {} }
  let(:distributor) { described_class.new(args) }

  describe '#report_tests' do
    subject { distributor.report_tests }
    it { should eql ['a_spec.rb', 'b_spec.rb', 'c_spec.rb', 'd_spec.rb'] }
  end

  describe '#all_tests' do
    subject { distributor.all_tests }

    context 'when given test_file_pattern' do
      context 'spec/**/*_spec.rb' do
        it { should_not be_empty }
        it { should include 'spec/knapsack/tracker_spec.rb' }
        it { should include 'spec/knapsack/adapters/rspec_adapter_spec.rb' }
      end

      context 'spec_examples/**/*_spec.rb' do
        let(:test_file_pattern) { 'spec_examples/**/*_spec.rb' }

        it { should_not be_empty }
        it { should include 'spec_examples/fast/1_spec.rb' }
        it { should include 'spec_examples/leftover/a_spec.rb' }
      end
    end

    context 'when fake test_file_pattern' do
      let(:test_file_pattern) { 'fake_pattern' }
      it { should be_empty }
    end

    context 'when missing test_file_pattern' do
      let(:test_file_pattern) { nil }
      it { expect { subject }.to raise_error('Missing test_file_pattern') }
    end
  end

  describe '#leftover_tests' do
    subject { distributor.leftover_tests }

    before do
      expect(distributor).to receive(:all_tests).and_return([
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
    let(:leftover_tests) {[
      'a_spec.rb',
      'b_spec.rb',
      'c_spec.rb',
      'd_spec.rb',
      'e_spec.rb',
      'f_spec.rb',
      'g_spec.rb',
    ]}

    before do
      expect(distributor).to receive(:leftover_tests).and_return(leftover_tests)
    end

    describe '#assign_test_files_to_node' do
      before do
        distributor.assign_test_files_to_node
      end

      it do
        expect(distributor.node_tests[0]).to eql([
          'a_spec.rb',
          'd_spec.rb',
          'g_spec.rb',
        ])
      end

      it do
        expect(distributor.node_tests[1]).to eql([
          'b_spec.rb',
          'e_spec.rb',
        ])
      end

      it do
        expect(distributor.node_tests[2]).to eql([
          'c_spec.rb',
          'f_spec.rb',
        ])
      end
    end

    describe '#tests_for_node' do
      it do
        expect(distributor.tests_for_node(1)).to eql([
          'b_spec.rb',
          'e_spec.rb',
        ])
      end
    end
  end
end
