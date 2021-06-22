require 'test_helper'

class FakeCalculator
  def add(x, y)
    x + y
  end

  def mal(x, y)
    x * y
  end
end

describe FakeCalculator do
  before do
    @calc = FakeCalculator.new
  end

  it '#add' do
    result = @calc.add(2, 3)

    if self.respond_to?(:_)
      _(result).must_equal 5
    else
      result.must_equal 5
    end
  end

  it '#mal' do
    result = @calc.mal(2, 3)

    if self.respond_to?(:_)
      _(result).must_equal 6
    else
      result.must_equal 6
    end
  end
end
