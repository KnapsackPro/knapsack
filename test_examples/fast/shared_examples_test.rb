require 'test_helper'

class Minitest::SharedExamples < Module
  include Minitest::Spec::DSL if RUBY_VERSION != "1.9.3"
end

SharedExampleSpec = Minitest::SharedExamples.new do
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
    skip 'test this later'
  end
end

describe "test that use SharedExamples" do
  include SharedExampleSpec
end
