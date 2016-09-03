module FakeMinitest
  class Test < ::Minitest::Test
    include Knapsack::Adapters::MinitestAdapter::BindTimeTrackerMinitestPlugin
  end
end

describe Knapsack::Adapters::MinitestAdapter do
  describe 'BindTimeTrackerMinitestPlugin' do
    let(:tracker) { instance_double(Knapsack::Tracker) }

    subject { ::FakeMinitest::Test.new }

    before do
      allow(Knapsack).to receive(:tracker).and_return(tracker)
    end

    describe '#before_setup' do
      let(:file) { 'test/models/user_test.rb' }

      it do
        expect(described_class).to receive(:test_path).with(subject).and_return(file)
        expect(tracker).to receive(:test_path=).with(file)
        expect(tracker).to receive(:start_timer)

        subject.before_setup
      end
    end

    describe '#after_teardown' do
      it do
        expect(tracker).to receive(:stop_timer)

        subject.after_teardown
      end
    end
  end

  describe 'bind methods' do
    let(:logger) { instance_double(Knapsack::Logger) }
    let(:global_time) { 'Global time: 01m 05s' }

    before do
      expect(Knapsack).to receive(:logger).and_return(logger)
    end

    describe '#bind_time_tracker' do
      it do
        expect(::Minitest::Test).to receive(:send).with(:include, Knapsack::Adapters::MinitestAdapter::BindTimeTrackerMinitestPlugin)

        expect(::Minitest).to receive(:after_run).and_yield
        expect(Knapsack::Presenter).to receive(:global_time).and_return(global_time)
        expect(logger).to receive(:info).with(global_time)

        subject.bind_time_tracker
      end
    end

    describe '#bind_report_generator' do
      let(:report) { instance_double(Knapsack::Report) }
      let(:report_details) { 'Report details' }

      it do
        expect(::Minitest).to receive(:after_run).and_yield

        expect(Knapsack).to receive(:report).and_return(report)
        expect(report).to receive(:save)

        expect(Knapsack::Presenter).to receive(:report_details).and_return(report_details)
        expect(logger).to receive(:info).with(report_details)

        subject.bind_report_generator
      end
    end

    describe '#bind_time_offset_warning' do
      let(:time_offset_warning) { 'Time offset warning' }
      let(:log_level) { :info }

      it 'creates a post-run callback to log the time offset message at the specified log level' do
        expect(::Minitest).to receive(:after_run).and_yield

        expect(Knapsack::Presenter).to receive(:time_offset_warning).and_return(time_offset_warning)
        expect(Knapsack::Presenter).to receive(:time_offset_log_level).and_return(log_level)
        expect(logger).to receive(:log).with(log_level, time_offset_warning)

        subject.bind_time_offset_warning
      end
    end
  end

  describe '#set_test_helper_path' do
    let(:adapter) { described_class.new }
    let(:test_helper_path) { '/code/project/test/test_helper.rb' }

    subject { adapter.set_test_helper_path(test_helper_path) }

    after do
      expect(described_class.class_variable_get(:@@parent_of_test_dir)).to eq '/code/project'
    end

    it { should eql '/code/project' }
  end

  describe '.test_path' do
    class FakeUserTest
      def test_user_age; end

      # method provided by Minitest
      # it returns test method name
      def name
        :test_user_age
      end
    end

    let(:obj) { FakeUserTest.new }

    subject { described_class.test_path(obj) }

    before do
      parent_of_test_dir = File.expand_path('../../../', File.dirname(__FILE__))
      parent_of_test_dir_regexp = Regexp.new("^#{parent_of_test_dir}")
      described_class.class_variable_set(:@@parent_of_test_dir, parent_of_test_dir_regexp)
    end

    it { should eq './spec/knapsack/adapters/minitest_adapter_spec.rb' }
  end

  describe '.test_path' do
    class FakeUserTest
      def fake_test
        include SharedExampleSpec
      end
      fake_test
    end

    let(:obj) { FakeUserTest.new }

    subject { described_class.test_path(obj) }

    before do
      parent_of_test_dir = File.expand_path('../../../', File.dirname(__FILE__))
      parent_of_test_dir_regexp = Regexp.new("^#{parent_of_test_dir}")
      described_class.class_variable_set(:@@parent_of_test_dir, parent_of_test_dir_regexp)
    end

    it { should eq './spec/knapsack/adapters/minitest_adapter_spec.rb' }
  end
end
