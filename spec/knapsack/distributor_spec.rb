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
    context 'when ci_node_total is given' do
      let(:args) { { ci_node_total: 4 } }

      it { expect(subject.ci_node_total).to eql 4 }
    end

    context 'when ci_node_total is not given' do
      it { expect(subject.ci_node_total).to eql 1 }
    end
  end

  describe '#ci_node_index' do
    context 'when ci_node_index is given' do
      let(:args) { { ci_node_index: 3 } }

      it { expect(subject.ci_node_index).to eql 3 }
    end

    context 'when ci_node_index is not given' do
      it { expect(subject.ci_node_index).to eql 0 }
    end
  end

  describe '#sorted_report' do
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
    let(:args) { { report: report } }

    it do
      expect(subject.sorted_report).to eql([
        ["f_spec.rb", 3.5],
        ["e_spec.rb", 3.0],
        ["d_spec.rb", 2.5],
        ["c_spec.rb", 2.0],
        ["b_spec.rb", 1.5],
        ["a_spec.rb", 1.0],
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
    let(:args) { { report: report } }

    describe '#total_time_execution' do
      context 'when time is float' do
        it { expect(subject.total_time_execution).to eql 5.5 }
      end

      context 'when time is not float' do
        let(:report) do
          {
            'a_spec.rb' => 3,
            'b_spec.rb' => 1,
          }
        end

        it { expect(subject.total_time_execution).to eql 4.0 }
      end
    end

    describe '#node_time_execution' do
      let(:args) { { report: report, ci_node_total: 4 } }
      it { expect(subject.node_time_execution).to eql 1.375 }
    end
  end

  describe '#assign_spec_files_to_node' do
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
    let(:args) do
      {
        report: report,
        ci_node_total: 3
      }
    end

    it do
      puts subject.total_time_execution
      puts subject.node_time_execution

      puts subject.sorted_report.inspect

      subject.assign_spec_files_to_node

      puts 'node_specs:'
      puts subject.node_specs
      #expect(subject.node_specs).to eql({}) # FIXME
    end
  end
end
