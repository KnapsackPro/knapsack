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

    it { should eql 'Knapsack global time execution for specs: 4.2s' }
  end

  describe '.report_details' do
    subject { described_class.report_details }

    before do
      expect(described_class).to receive(:report_json).and_return('{}')
    end

    it { should eql "Knapsack report was generated. Preview:\n{}" }
  end
end
