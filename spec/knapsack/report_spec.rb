describe Knapsack::Report do
  let(:report) { described_class.send(:new) }

  describe '#config' do
    context 'when passed options' do
      let(:opts) do
        {
          report_path: 'new_knapsack_report.json',
          fake: true
        }
      end

      it do
        expect(report.config(opts)).to eql({
          report_path: 'new_knapsack_report.json',
          fake: true
        })
      end
    end

    context "when didn't pass options" do
      it do
        expect(report.config).to eql({
          report_path: 'knapsack_report.json'
        })
      end
    end
  end

  # TODO improve it
  describe '#save' do
    let(:report_path) { 'tmp/fake_report.json' }

    before do
      expect(File.exist?(report_path)).to be false
      expect(report).to receive(:report_json).and_return('{}')
      report.config({
        report_path: report_path
      })
      report.save
    end

    it { expect(File.exist?(report_path)).to be true }
  end

  describe '.open' do
    # TODO
  end
end
