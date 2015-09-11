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
      it 'should be true when KNAPSACK_GENERATE_REPORT=true' do
        with_env 'KNAPSACK_GENERATE_REPORT' => 'true' do
          expect(subject).to eq(true)
        end
      end

      it 'should be true when KNAPSACK_GENERATE_REPORT=0' do
        with_env 'KNAPSACK_GENERATE_REPORT' => '0' do
          expect(subject).to eq(true)
        end
      end

      it 'should be false when KNAPSACK_GENERATE_REPORT is ""' do
        with_env 'KNAPSACK_GENERATE_REPORT' => '' do
          expect(subject).to eq(false)
        end
      end

      it 'should be false when KNAPSACK_GENERATE_REPORT is "false"' do
        with_env 'KNAPSACK_GENERATE_REPORT' => 'false' do
          expect(subject).to eq(false)
        end
      end

      it 'should be false when KNAPSACK_GENERATE_REPORT is not "true" or "0"' do
        with_env 'KNAPSACK_GENERATE_REPORT' => '1' do
          expect(subject).to eq(false)
        end
      end
    end

    context "when ENV doesn't exist" do
      it { should be false }
    end
  end
end
