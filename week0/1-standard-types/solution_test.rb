require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_the_truth
    assert_equal true, true
  end

  def test_histogram
    expected_histogram = { 'a' => 3, 'b' => 1, 'r' => 1, 'c' => 1 }
    assert_equal expected_histogram, histogram('abraca'), 'histogram is wrong'
  end

  def test_prime
    test_number = 104_729
    msg = "but #{test_number} is prime"

    assert_equal true, prime?(test_number), msg
  end

  def test_ordinal
    test_number = 123
    expected_value = "#{test_number}rd"

    assert_equal expected_value, ordinal(test_number)
  end

  def test_palindrome_number
    assert_equal true, palindrome?(123_532_1)
  end

  def test_palindrome_string
    assert_equal true, palindrome?('Race car')
  end

  def test_anagram
    assert_equal true, anagram?('silent', 'listen')
  end
end
