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
