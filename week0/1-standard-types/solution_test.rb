require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
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
    assert_equal true, palindrome?('Race car')
  end

  def test_anagram
    assert_equal true, anagram?('silent', 'listen')
    assert_equal false, anagram?('Mr Mojo Risin', 'Jim Morisson')
  end

  def test_remove_prefix
    assert_equal 'Night Out', remove_prefix('Ladies Night Out', 'Ladies')
  end

  def test_remove_no_prefix
    string = 'All the single ladies, all the single ladies'
    assert_equal string, remove_prefix(string, 'Ladies')
  end

  def test_remove_suffix
    assert_equal 'Ladies', remove_suffix('Ladies Night Out', ' Night Out')
  end

  def test_remove_suffix_multiple
    assert_equal 'Have a good night, night-',
                 remove_suffix('Have a good night, night-night', 'night')
  end

  def test_digits
    assert_equal [1, 2, 3, 4, 5], digits(12_345)
    assert_equal [], digits(nil)
  end

  def test_fizzbuzz
    assert_equal [1, 2, :fizz, 4, :buzz, :fizz, 7, 8, :fizz, :buzz, 11, :fizz,
                  13, 14, :fizz, :buzz, 16, 17, :fizz, 19, :buzz, :fizz, 22],
                 fizzbuzz(1..22)
  end

  def test_array_to_hash
    expected_hash = { 1 => 2, 3 => 4, 5 => 6 }
    assert_equal expected_hash, [[1, 2], [3, 4], [5, 6]].to_hash
  end

  def test_array_to_hash_collision
    expected_hash = { 1 => 7 }
    assert_equal expected_hash, [[1, 3], [1, 5], [1, 7]].to_hash
  end

  def test_array_index_by_length
    expected_hash = { 3 => 'bar', 6 => 'larodi' }
    assert_equal expected_hash, %w(foo larodi bar).index_by(&:length)
  end

  def test_array_index_by_last_name
    expected_hash = { 'Coltrane' => 'John Coltrane', 'Davis' => 'Miles Davis' }
    assert_equal expected_hash, ['John Coltrane', 'Miles Davis']
                 .index_by { |name| name.split(' ').last }
  end

  def test_array_subarray_count
    assert_equal 2, [1, 2, 3, 2, 3, 1].subarray_count([2, 3])
    assert_equal 3, [1, 2, 2, 2, 2, 1].subarray_count([2, 2])
    assert_equal 3, [1, 1, 2, 2, 1, 1, 1].subarray_count([1, 1])
  end

  def test_count_array_numbers
    expected_hash = { 1 => 2, 2 => 1, 3 => 1 }
    assert_equal expected_hash, count([1, 2, 3, 1])
  end

  def test_count_array_words
    expected_hash = { 'this' => 1, 'is' => 1, 'an' => 1, 'array' => 1,
                    'of' => 1, 'words' => 3 }
    assert_equal expected_hash, count(%w(this is an array of words words words))
  end

  def test_count_array_negative
    expected_hash = {}
    assert_equal expected_hash, count(nil)
  end

  def test_count_words
    expected_hash = { 'this' => 1, 'is' => 2, 'not' => 1, 'a' => 1,
                      'sentence' => 1, 'bro' => 2, "'till" => 1, 'later' => 1,
                      "who's" => 1, 'there' => 1, 'that' => 1, 'you' => 1 }
    assert_equal expected_hash,
                 count_words("This is not a sentence, bro, 'till later.",
                             "Who's there? Bro, is that you?.")
  end
end
