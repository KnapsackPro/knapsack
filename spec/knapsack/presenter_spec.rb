describe Knapsack::Presenter do
  let(:tracker) { instance_double(Knapsack::Tracker) }
  let(:test_files_with_time) do
    {
      'a_spec.rb' => 1.0,
      'b_spec.rb' => 0.4
    }
  end

  describe 'report methods' do
    before do
      expect(Knapsack).to receive(:tracker) { tracker }
      expect(tracker).to receive(:test_files_with_time).and_return(test_files_with_time)
    end

    describe '.report_yml' do
      subject { described_class.report_yml }
      it { should eql test_files_with_time.to_yaml }
    end

    describe '.report_json' do
      subject { described_class.report_json }
      it { should eql JSON.pretty_generate(test_files_with_time) }
    end
  end

  describe '.global_time' do
    subject { described_class.global_time }

    before do
      expect(Knapsack).to receive(:tracker) { tracker }
      expect(tracker).to receive(:global_time).and_return(60*62+3)
    end

    it { should eql "\nKnapsack global time execution for tests: 01h 02m 03s" }
  end

  describe '.report_details' do
    subject { described_class.report_details }

    before do
      expect(described_class).to receive(:report_json).and_return('{}')
    end

    it { should eql "Knapsack report was generated. Preview:\n{}" }
  end

  describe '.time_offset_log_level' do
    before do
      allow(Knapsack).to receive(:tracker) { tracker }
      allow(tracker).to receive(:time_exceeded?).and_return(time_exceeded)
    end

    context 'when the time offset is exceeded' do
      let(:time_exceeded) { true }

      it 'returns a WARN log level' do
        expect(described_class.time_offset_log_level).to eq(Knapsack::Logger::WARN)
      end
    end

    context 'when the time offset is not exceeded' do
      let(:time_exceeded) { false }

      it 'returns an INFO log level' do
        expect(described_class.time_offset_log_level).to eq(Knapsack::Logger::INFO)
      end
    end
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
      it { should include 'Max allowed node time execution: 01m' }
      it { should include 'Exceeded time: 03s' }
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

  describe '.pretty_seconds' do
    subject { described_class.pretty_seconds(seconds) }

    context 'when less then one second' do
      let(:seconds) { 0.987 }
      it { should eql '0.987s' }
    end

    context 'when one second' do
      let(:seconds) { 1 }
      it { should eql '01s' }
    end

    context 'when only seconds' do
      let(:seconds) { 5 }
      it { should eql '05s' }
    end

    context 'when only minutes' do
      let(:seconds) { 120 }
      it { should eql '02m' }
    end

    context 'when only hours' do
      let(:seconds) { 60*60*3 }
      it { should eql '03h' }
    end

    context 'when minutes and seconds' do
      let(:seconds) { 180+9 }
      it { should eql '03m 09s' }
    end

    context 'when all' do
      let(:seconds) { 60*60*4+120+7 }
      it { should eql '04h 02m 07s' }
    end

    context 'when negative seconds' do
      let(:seconds) { -67 }
      it { should eql '-01m 07s' }
    end
  end
end
