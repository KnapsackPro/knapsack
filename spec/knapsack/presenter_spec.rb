describe Knapsack::Presenter do
  let(:tracker) { instance_double(Knapsack::Tracker) }
  let(:spec_files_with_time) do
    {
      'a_spec.rb' => 1.0,
      'b_spec.rb' => 0.4
    }
  end

  describe 'report methods' do
    before do
      expect(Knapsack).to receive(:tracker) { tracker }
      expect(tracker).to receive(:spec_files_with_time).and_return(spec_files_with_time)
    end

    describe '.report_yml' do
      subject { described_class.report_yml }
      it { should eql spec_files_with_time.to_yaml }
    end

    describe '.report_json' do
      subject { described_class.report_json }
      it { should eql JSON.pretty_generate(spec_files_with_time) }
    end
  end

  describe '.global_time' do
    subject { described_class.global_time }

    before do
      expect(Knapsack).to receive(:tracker) { tracker }
      expect(tracker).to receive(:global_time).and_return(4.2)
    end

    it { should eql "\nKnapsack global time execution for specs: 4.2s" }
  end

  describe '.report_details' do
    subject { described_class.report_details }

    before do
      expect(described_class).to receive(:report_json).and_return('{}')
    end

    it { should eql "Knapsack report was generated. Preview:\n{}" }
  end

  describe '.time_offset_warning' do
    let(:time_offset_in_seconds) { 30 }
    let(:max_node_time_execution) { 60 }
    let(:exceeded_time) { 3 }

    subject { described_class.time_offset_warning }

    before do
      allow(Knapsack).to receive(:tracker) { tracker }
      expect(tracker).to receive(:config).and_return({time_offset_in_seconds: time_offset_in_seconds})
      expect(tracker).to receive(:max_node_time_execution).and_return(max_node_time_execution)
      expect(tracker).to receive(:exceeded_time).and_return(exceeded_time)
      expect(tracker).to receive(:time_exceeded?).and_return(time_exceeded?)
    end

    shared_examples 'knapsack time offset warning' do
      it { should include 'Time offset: 30s' }
      it { should include 'Max allowed node time execution: 60s' }
      it { should include 'Exceeded time: 3s' }
    end

    context 'when time exceeded' do
      let(:time_exceeded?) { true }

      it_behaves_like 'knapsack time offset warning'
      it { should include 'Please regenerate your knapsack report.' }
    end

    context "when time did not exceed" do
      let(:time_exceeded?) { false }

      it_behaves_like 'knapsack time offset warning'
      it { should include 'Global time execution for this CI node is fine.' }
    end
  end
end
