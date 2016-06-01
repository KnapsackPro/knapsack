describe Knapsack::Logger do
  let(:text) { 'Text' }

  describe '#debug' do
    before { subject.level = level }

    context 'when level is DEBUG' do
      let(:level) { described_class::DEBUG }
      it { expect { subject.debug(text) }.to output(/#{text}/).to_stdout }
    end

    context 'when level is INFO' do
      let(:level) { described_class::INFO }
      it { expect { subject.debug(text) }.to output('').to_stdout }
    end

    context 'when level is WARN' do
      let(:level) { described_class::WARN }
      it { expect { subject.debug(text) }.to output('').to_stdout }
    end
  end

  describe '#info' do
    before { subject.level = level }

    context 'when level is DEBUG' do
      let(:level) { described_class::DEBUG }
      it { expect { subject.info(text) }.to output(/#{text}/).to_stdout }
    end

    context 'when level is INFO' do
      let(:level) { described_class::INFO }
      it { expect { subject.info(text) }.to output(/#{text}/).to_stdout }
    end

    context 'when level is WARN' do
      let(:level) { described_class::WARN }
      it { expect { subject.info(text) }.to output('').to_stdout }
    end
  end

  describe '#warn' do
    before { subject.level = level }

    context 'when level is DEBUG' do
      let(:level) { described_class::DEBUG }
      it { expect { subject.warn(text) }.to output(/#{text}/).to_stdout }
    end

    context 'when level is INFO' do
      let(:level) { described_class::INFO }
      it { expect { subject.warn(text) }.to output(/#{text}/).to_stdout }
    end

    context 'when level is WARN' do
      let(:level) { described_class::WARN }
      it { expect { subject.warn(text) }.to output(/#{text}/).to_stdout }
    end
  end

  describe '#log' do
    let(:log_level) { Knapsack::Logger::INFO }
    let(:log_message) { 'log-message' }

    it 'delegates to the method matching the specified log level' do
      expect(subject).to receive(:info).with(log_message)

      subject.log(log_level, log_message)
    end

    context 'when the log level is unknown' do
      let(:log_level) { 5 }

      it 'raises an UnknownLogLevel error' do
        expect {
          subject.log(log_level, log_message)
        }.to raise_error Knapsack::Logger::UnknownLogLevel
      end
    end
  end
end
