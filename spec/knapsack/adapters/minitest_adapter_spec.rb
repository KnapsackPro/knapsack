describe Knapsack::Adapters::MinitestAdapter do
  describe Knapsack::Adapters::MinitestAdapter::BindTimeTrackerMinitestPlugin do

  end

  describe 'bind methods' do
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
end
