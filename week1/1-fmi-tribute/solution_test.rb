require 'minitest/autorun'

require_relative 'solution'

class ArrayTest < Minitest::Test
  def test_to_hash
    assert_equal({ one: 1, two: 2 }, [[:one, 1], [:two, 2]].to_hash)
  end

  def test_index_by
    assert_equal({ 'Coltrane' => 'John Coltrane', 'Davis' => 'Miles Davis' },
                 ['John Coltrane', 'Miles Davis']
                   .index_by { |name| name.split(' ').last })
  end

  def test_occurences_count
    assert_equal({ foo: 2, bar: 1 }, [:foo, :bar, :foo].occurences_count)
  end

  def test_subarray_count
    assert_equal 3, [1, 2, 3, 3, 2, 3, 3, 3, 1].subarray_count([3, 3])
  end

  def test_subarray_count_harder
    assert_equal 2, [(2 + 3i), (1 + 1i), (4 + 2i), (4 + 2i), (-3 + 4i),
                     (1 + 1i), (4 + 2i)].subarray_count([(1 + 1i), (4 + 2i)])
  end
end
