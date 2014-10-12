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

  def test_anagram_negative
    assert_equal false, anagram?('Mr Mojo Risin', 'Jim Morisson')
  end

  def test_remove_prefix
    assert_equal 'Night Out', remove_prefix('Ladies Night Out', 'Ladies')
  end

  def test_remove_sufix
    assert_equal 'Ladies', remove_suffix('Ladies Night Out', ' Night Out')
  end

  def test_digits
    assert_equal [1, 2, 3, 4, 5], digits(12345)
  end

  def test_fizzbuzz
    assert_equal [1, 2, :fizz, 4, :buzz, :fizz, 7, 8, :fizz, :buzz, 11, :fizz, 13, 14,
                 :fizz, :buzz, 16, 17, :fizz, 19, :buzz, :fizz, 22], fizzbuzz(1..22)
  end

  def test_array_to_hash
    expected_hash = { 1 => 2, 3 => 4, 5 => 6 }
    assert_equal expected_hash, [[1, 2], [3, 4], [5, 6]].to_hash
  end

  def test_array_to_hash_collision
    expected_hash = { 1 => 7 }
    assert_equal expected_hash, [[1, 3], [1, 5], [1, 7]].to_hash
  end
end
