require 'spec_helper'

describe Knapsack::Tracker do
  let(:tracker) { described_class.send(:new) }

  describe 'attributes' do
    it { expect(tracker.global_time).to eql 0 }
    it { expect(tracker.files).to eql({}) }
  end

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
          time_offset_warning: 30,
          fake: true
        })
      end
    end

    context "when didn't pass options" do
      it do
        expect(tracker.config).to eql({
          enable_time_offset_warning: true,
          time_offset_warning: 30,
        })
      end
    end
  end
end
