describe Knapsack::Adapters::CucumberAdapter do
  context do
    before do
      allow(::Cucumber::RbSupport::RbDsl).to receive(:register_rb_hook)
      allow(Kernel).to receive(:at_exit)
    end

    it_behaves_like 'adapter'
  end
end
