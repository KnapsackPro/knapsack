shared_examples 'default trakcer attributes' do
  it { expect(tracker.global_time).to eql 0 }
  it { expect(tracker.spec_files_with_time).to eql({}) }
end

describe Knapsack::Tracker do
  let(:tracker) { described_class.send(:new) }

  it_behaves_like 'default trakcer attributes'

  describe '#generate_report?' do
    subject { tracker.generate_report? }

    context 'when ENV variable is defined' do
      before do
        stub_const("ENV", { 'KNAPSACK_GENERATE_REPORT' => true })
      end
      it { should be true }
    end

    context 'when ENV variable is not defined' do
      it { should be false }
    end
  end

  describe '#config' do
    context 'when passed options' do
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
          fake: true
        })
      end
    end

    context "when didn't pass options" do
      it do
        expect(tracker.config).to eql({
          enable_time_offset_warning: true,
          time_offset_in_seconds: 30,
        })
      end
    end
  end

  describe '#spec_path' do
    subject { tracker.spec_path }

    context 'when spec_path not set' do
      it do
        expect { subject }.to raise_error("spec_path needs to be set by Knapsack Adapter's bind method")
      end
    end

    context 'when spec_path set' do
      context 'when spec path has prefix ./' do
        before { tracker.spec_path = './spec/models/user_spec.rb' }
        it { should eql 'spec/models/user_spec.rb' }
      end

      context 'when spec path has not prefix ./' do
        before { tracker.spec_path = 'spec/models/user_spec.rb' }
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
    let(:now) { Time.now }
    let(:spec_paths) { ['a_spec.rb', 'b_spec.rb'] }

    before do
      spec_paths.each_with_index do |spec_path, index|
        Timecop.freeze(now) do
          tracker.spec_path = spec_path
          tracker.start_timer
        end

        seconds = index + 1
        Timecop.freeze(now+seconds) do
          tracker.stop_timer
        end
      end
    end

    it { expect(tracker.global_time).to eql 3.0 }
    it do
      expect(tracker.spec_files_with_time).to eql({
        'a_spec.rb' => 1.0,
        'b_spec.rb' => 2.0,
      })
    end

    context '#reset!' do
      before { tracker.reset! }
      it_behaves_like 'default trakcer attributes'
    end
  end
end
