describe Knapsack::Report do
  let(:report) { described_class.send(:new) }
  let(:report_path) { 'tmp/fake_report.json' }
  let(:report_json) do
    %Q[{"a_spec.rb": #{rand(Math::E..Math::PI)}}]
  end

  describe '#config' do
    context 'when passed options' do
      let(:args) do
        {
          report_path: 'knapsack_new_report.json',
          fake: true
        }
      end

      it do
        expect(report.config(args)).to eql({
          report_path: 'knapsack_new_report.json',
          fake: true
        })
      end
    end

    context "when didn't pass options" do
      it { expect(report.config).to eql({}) }
    end
  end

  describe '#save', :clear_tmp do
    before do
      expect(report).to receive(:report_json).and_return(report_json)
      report.config({
        report_path: report_path
      })
      report.save
    end

    it { expect(File.read(report_path)).to eql report_json }
  end

  describe '.open' do
    let(:subject) { report.open }

    before do
      report.config({
        report_path: report_path
      })
    end

    context 'when report file exists' do
      before do
        expect(File).to receive(:read).with(report_path).and_return(report_json)
      end

      it { should eql(JSON.parse(report_json)) }
    end

    context "when report file doesn't exist" do
      let(:report_path) { 'tmp/non_existing_report.json' }

      it do
        expect {
          subject
        }.to raise_error("Knapsack report file doesn't exist. Please generate report first!")
      end
    end
  end
end
