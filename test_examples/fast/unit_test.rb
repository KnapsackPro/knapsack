require 'minitest/autorun'

class UnitTest < Minitest::Test
  def setup
    sleep 0.1
  end

  def test_mal
    sleep 0.1
    assert_equal 4, 2 * 2
  end

  def test_no_way
    sleep 0.2
    refute_match(/^no/i, 'yes')
  end

  def test_that_will_be_skipped
    sleep 1
    skip 'test this later'
  end
end
