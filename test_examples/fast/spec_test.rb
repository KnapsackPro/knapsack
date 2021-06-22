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
    _(@calc.add(2, 3)).must_equal 5
  end

  it '#mal' do
    _(@calc.mal(2, 3)).must_equal 6
  end
end
