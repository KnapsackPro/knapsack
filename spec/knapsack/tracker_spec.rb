shared_examples 'default trakcer attributes' do
  it { expect(tracker.global_time).to eql 0 }
  it { expect(tracker.test_files_with_time).to eql({}) }
end

describe Knapsack::Tracker do
  let(:tracker) { described_class.send(:new) }

  it_behaves_like 'default trakcer attributes'

  describe '#config' do
    before do
      stub_const("ENV", { 'KNAPSACK_GENERATE_REPORT' => generate_report })
    end

    context 'when passed options' do
      let(:generate_report) { true }
      let(:opts) do
        {
          enable_time_offset_warning: false,
          fake: true
        }
      end

      it do
        expect(tracker.config(opts)).to eql({
          enable_time_offset_warning: false,
          time_offset_in_seconds: 30,
          generate_report: true,
          fake: true
        })
      end
    end

    context "when didn't pass options" do
      let(:generate_report) { nil }

      it do
        expect(tracker.config).to eql({
          enable_time_offset_warning: true,
          time_offset_in_seconds: 30,
          generate_report: false
        })
      end
    end
  end

  describe '#test_path' do
    subject { tracker.test_path }

    context 'when test_path not set' do
      it do
        expect { subject }.to raise_error("test_path needs to be set by Knapsack Adapter's bind method")
      end
    end

    context 'when test_path set' do
      context 'when test_path has prefix ./' do
        before { tracker.test_path = './spec/models/user_spec.rb' }
        it { should eql 'spec/models/user_spec.rb' }
      end

      context 'when test_path has not prefix ./' do
        before { tracker.test_path = 'spec/models/user_spec.rb' }
        it { should eql 'spec/models/user_spec.rb' }
      end
    end
  end

  describe '#time_exceeded?' do
    subject { tracker.time_exceeded? }

    before do
      expect(tracker).to receive(:global_time).and_return(global_time)
      expect(tracker).to receive(:max_node_time_execution).and_return(max_node_time_execution)
    end

    context 'when true' do
      let(:global_time) { 2 }
      let(:max_node_time_execution) { 1 }
      it { should be true }
    end

    context 'when false' do
      let(:global_time) { 1 }
      let(:max_node_time_execution) { 1 }
      it { should be false }
    end
  end

  describe '#max_node_time_execution' do
    let(:report_distributor) { instance_double(Knapsack::Distributors::ReportDistributor) }
    let(:node_time_execution) { 3.5 }
    let(:max_node_time_execution) { node_time_execution + tracker.config[:time_offset_in_seconds] }

    subject { tracker.max_node_time_execution }

    before do
      expect(tracker).to receive(:report_distributor).and_return(report_distributor)
      expect(report_distributor).to receive(:node_time_execution).and_return(node_time_execution)
    end

    it { should eql max_node_time_execution }
  end

  describe '#exceeded_time' do
    let(:global_time) { 5 }
    let(:max_node_time_execution) { 2 }

    subject { tracker.exceeded_time }

    before do
      expect(tracker).to receive(:global_time).and_return(global_time)
      expect(tracker).to receive(:max_node_time_execution).and_return(max_node_time_execution)
    end

    it { should eql 3 }
  end

  describe 'track time execution' do
    let(:test_paths) { ['a_spec.rb', 'b_spec.rb'] }
    let(:delta) { 0.02 }

    shared_examples 'test tracker' do
      it { expect(tracker.global_time).to be_within(delta).of(0.3) }
      it { expect(tracker.test_files_with_time.keys.size).to eql 2 }
      it { expect(tracker.test_files_with_time['a_spec.rb']).to be_within(delta).of(0.1) }
      it { expect(tracker.test_files_with_time['b_spec.rb']).to be_within(delta).of(0.2) }
    end

    context 'without Timecop' do
      before do
        test_paths.each_with_index do |test_path, index|
          tracker.test_path = test_path
          tracker.start_timer
          sleep index.to_f / 10 + 0.1
          tracker.stop_timer
        end
      end

      it { expect(tracker.global_time).to be_within(delta).of(0.3) }
      it { expect(tracker.test_files_with_time.keys.size).to eql 2 }
      it { expect(tracker.test_files_with_time['a_spec.rb']).to be_within(delta).of(0.1) }
      it { expect(tracker.test_files_with_time['b_spec.rb']).to be_within(delta).of(0.2) }
    end

    context "with Timecop - Timecop shouldn't have impact on measured test time" do
      let(:now) { Time.now }

      before do
        test_paths.each_with_index do |test_path, index|
          Timecop.freeze(now) do
            tracker.test_path = test_path
            tracker.start_timer
          end

          delay = index + 1
          Timecop.freeze(now+delay) do
            tracker.stop_timer
          end
        end
      end

      it { expect(tracker.global_time).to be > 0 }
      it { expect(tracker.global_time).to be_within(delta).of(0) }
      it { expect(tracker.test_files_with_time.keys.size).to eql 2 }
      it { expect(tracker.test_files_with_time['a_spec.rb']).to be_within(delta).of(0) }
      it { expect(tracker.test_files_with_time['b_spec.rb']).to be_within(delta).of(0) }
    end
  end

  describe '#reset!' do
    before do
      tracker.test_path = 'a_spec.rb'
      tracker.start_timer
      sleep 0.1
      tracker.stop_timer
      expect(tracker.global_time).not_to eql 0
      tracker.reset!
    end

    it_behaves_like 'default trakcer attributes'
  end
end
