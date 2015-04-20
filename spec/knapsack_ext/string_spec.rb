module FakeModule
  class FakeClass
  end
end

describe KnapsackExt::String do
  describe '.underscore_and_drop_module' do
    subject { described_class.underscore_and_drop_module(class_or_string) }

    {
      'MySuperClass' => 'my_super_class',
      'Module::SuperClass' => 'super_class',
      FakeModule::FakeClass => 'fake_class',
    }.each do |given, expected|
      context "when #{given}" do
        let(:class_or_string) { given }
        it { should eq expected }
      end
    end
  end
end
