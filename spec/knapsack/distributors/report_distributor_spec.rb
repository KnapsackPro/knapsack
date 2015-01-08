describe Knapsack::Distributors::ReportDistributor do
  let(:report) { { 'a_spec.rb' => 1.0 } }
  let(:default_args) do
    {
      report: report,
      test_file_pattern: 'spec/**/*_spec.rb',
      ci_node_total: '1',
      ci_node_index: '0'
    }
  end
  let(:args) { default_args.merge(custom_args) }
  let(:custom_args) { {} }
  let(:distributor) { described_class.new(args) }

  describe '#sorted_report' do
    subject { distributor.sorted_report }

    let(:report) do
      {
        'e_spec.rb' => 3.0,
        'f_spec.rb' => 3.5,
        'c_spec.rb' => 2.0,
        'd_spec.rb' => 2.5,
        'a_spec.rb' => 1.0,
        'b_spec.rb' => 1.5,
      }
    end

    it do
      should eql([
        ['f_spec.rb', 3.5],
        ['e_spec.rb', 3.0],
        ['d_spec.rb', 2.5],
        ['c_spec.rb', 2.0],
        ['b_spec.rb', 1.5],
        ['a_spec.rb', 1.0],
      ])
    end
  end

  describe '#sorted_report_with_existing_tests' do
    subject { distributor.sorted_report_with_existing_tests }

    let(:report) do
      {
        'e_spec.rb' => 3.0,
        'f_spec.rb' => 3.5,
        'c_spec.rb' => 2.0,
        'd_spec.rb' => 2.5,
        'a_spec.rb' => 1.0,
        'b_spec.rb' => 1.5,
      }
    end

    before do
      expect(distributor).to receive(:all_tests).exactly(6).times.and_return([
        'b_spec.rb',
        'd_spec.rb',
        'f_spec.rb',
      ])
    end

    it do
      should eql([
        ['f_spec.rb', 3.5],
        ['d_spec.rb', 2.5],
        ['b_spec.rb', 1.5],
      ])
    end
  end

  context do
    let(:report) do
      {
        'a_spec.rb' => 3.0,
        'b_spec.rb' => 1.0,
        'c_spec.rb' => 1.5,
      }
    end

    before do
      allow(distributor).to receive(:all_tests).and_return(report.keys)
    end

    describe '#total_time_execution' do
      subject { distributor.total_time_execution }

      context 'when time is float' do
        it { should eql 5.5 }
      end

      context 'when time is not float' do
        let(:report) do
          {
            'a_spec.rb' => 3,
            'b_spec.rb' => 1,
          }
        end

        it { should eql 4.0 }
      end
    end

    describe '#node_time_execution' do
      subject { distributor.node_time_execution }
      let(:custom_args) { { ci_node_total: 4 } }
      it { should eql 1.375 }
    end
  end

  context do
    let(:report) do
      {
        'g_spec.rb' => 9.0,
        'h_spec.rb' => 3.0,
        'i_spec.rb' => 3.0,
        'f_spec.rb' => 3.5,
        'c_spec.rb' => 2.0,
        'd_spec.rb' => 2.5,
        'a_spec.rb' => 1.0,
        'b_spec.rb' => 1.5,
      }
    end
    let(:custom_args) { { ci_node_total: 3 } }

    before do
      allow(distributor).to receive(:all_tests).and_return(report.keys)
    end

    describe '#assign_test_files_to_node' do
      before { distributor.assign_test_files_to_node }

      it do
        expect(distributor.node_tests[0]).to eql({
          :node_index => 0,
          :time_left => -0.5,
          :test_files_with_time => [
            ["g_spec.rb", 9.0]
          ]
        })
      end

      it do
        expect(distributor.node_tests[1]).to eql({
          :node_index => 1,
          :time_left => 0.0,
          :test_files_with_time => [
            ["f_spec.rb", 3.5],
            ["d_spec.rb", 2.5],
            ["b_spec.rb", 1.5],
            ["a_spec.rb", 1.0]
          ]
        })
      end

      it do
        expect(distributor.node_tests[2]).to eql({
          :node_index => 2,
          :time_left => 0.5,
          :test_files_with_time => [
            ["i_spec.rb", 3.0],
            ["h_spec.rb", 3.0],
            ["c_spec.rb", 2.0]
          ]
        })
      end
    end

    describe '#tests_for_node' do
      context 'when node exists' do
        it do
          expect(distributor.tests_for_node(1)).to eql([
            'f_spec.rb',
            'd_spec.rb',
            'b_spec.rb',
            'a_spec.rb'
          ])
        end
      end

      context "when node doesn't exist" do
        it { expect(distributor.tests_for_node(42)).to be_nil }
      end
    end
  end
end
