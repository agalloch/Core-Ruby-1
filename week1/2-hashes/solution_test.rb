require 'minitest/autorun'

require_relative 'solution'

class HashTest < Minitest::Test
  def test_the_truth
    assert true
  end

  def test_pick
    expected_hash = { a: 1, b: 2 }
    assert_equal expected_hash, { a: 1, b: 2, c: 3 }.pick(:a, :b)
  end

  def test_except
    expected_hash = { a: 1, b: 2 }
    assert_equal expected_hash, { a: 1, b: 2, d: nil }.except(:d)
  end

  def test_compact_values
    expected_hash = { a: 1, b: 2 }
    assert_equal expected_hash, { a: 1, b: 2, c: false, d: nil }.compact_values
  end

  def test_defaults
    expected_hash = { a: 1, b: 2, c: 3 }
    assert_equal expected_hash, { a: 1, b: 2 }.defaults(a: 4, c: 3)
  end
end
