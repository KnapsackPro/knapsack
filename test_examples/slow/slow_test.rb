require 'test_helper'

class SlowTest < Minitest::Test
  def setup
    sleep 0.5
  end

  def test_a
    sleep 0.5
  end

  def test_b
    sleep 1.0
  end
end
