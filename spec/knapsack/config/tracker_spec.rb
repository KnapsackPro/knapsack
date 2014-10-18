describe Knapsack::Config::Tracker do
  describe '.enable_time_offset_warning' do
    subject { described_class.enable_time_offset_warning }
    it { should be true }
  end

  describe '.time_offset_in_seconds' do
    subject { described_class.time_offset_in_seconds }
    it { should eql 30 }
  end

  describe '.generate_report' do
    subject { described_class.generate_report }

    context 'when ENV exists' do
      before { stub_const("ENV", { 'KNAPSACK_GENERATE_REPORT' => true }) }
      it { should be true }
    end

    context "when ENV doesn't exist" do
      it { should be false }
    end
  end
end
