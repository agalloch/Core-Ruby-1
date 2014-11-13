require 'minitest/autorun'
require 'pry'

require_relative 'solution'

class SolutionTest < Minitest::Test
  class Collection
    include MyEnumerable

    def initialize(*data)
      @data = data
    end

    def each(&block)
      @data.each(&block)
    end

    def add(*items)
      items.each { |item| @data << item }
    end
  end

  def setup
    @collection = Collection.new(*1..10)
  end

  def test_map
    assert_equal((2..6).to_a, Collection.new(*1..5).map(&:succ))
  end

  def test_collect
    assert_equal((2..6).to_a, Collection.new(*1..5).collect(&:succ))
  end

  def test_filter
    assert_equal [1, 3, 5, 7, 9], @collection.filter(&:odd?)
  end

  def test_select
    assert_equal [1, 3, 5, 7, 9], @collection.select(&:odd?)
  end

  def test_reject
    assert_equal [1, 3, 5, 7, 9], @collection.reject(&:even?)
  end

  def test_reduce_initial_and_block
    assert_equal 55, @collection.reduce(0) { |memo, item| memo + item }
  end

  def test_reduce_initial_and_symbol
    assert_equal(-3_628_800, @collection.reduce(-1, :*))
  end

  def test_reduce_symbol
    assert_equal(-53, @collection.reduce(:-))
  end

  def test_reduce_block
    assert_equal 385, @collection.reduce { |memo, item| memo + item**2 }
  end

  def test_reduce_symbol_and_block
    assert_equal 100, @collection.reduce(:+) { |_, item| item**2 }
  end

  def test_fold_initial_and_block
    assert_equal 55, @collection.fold(0) { |memo, item| memo + item }
  end

  def test_fold_initial_and_symbol
    assert_equal(-3_628_800, @collection.fold(-1, :*))
  end

  def test_fold_symbol
    assert_equal(-53, @collection.fold(:-))
  end

  def test_fold_block
    assert_equal 385, @collection.fold { |memo, item| memo + item**2 }
  end

  def test_fold_symbol_and_block
    assert_equal 100, @collection.fold(:+) { |_, item| item**2 }
  end

  def test_include?
    assert_equal true, @collection.include?(5)
  end

  def test_any?
    collection = Collection.new(false, false, nil, nil, false, 8, false, nil)
    assert_equal true, collection.any?
  end

  def test_all?
    assert_equal true, @collection.all?
  end

  def test_one?
    assert_equal true, Collection.new(nil, nil, 5, false, false).one?
  end

  def test_one_negative
    assert_equal false, Collection.new(1, 2, 3, 4, nil).one?
  end

  def test_one_with_block
    @collection = Collection.new(
      'uno', 'four', 'equatorial skunk', 'frog-stomp')

    assert_equal true, @collection.one? { |item| item.include? '-' }
  end

  def test_one_with_block_negative
    @collection = Collection.new(
      'Highlander', 'Neo', 'Mr. Anderson', 'Mr. Bean', 'Neo')

    assert_equal false, @collection.one? { |item| item == 'Neo' }
  end

  def test_size
    assert_equal 10, @collection.size
  end

  def test_default_count
    assert_equal 10, @collection.count
  end

  def test_count_item
    @collection.add 8, 9, 9
    assert_equal 3, @collection.count(9)
  end

  def test_count_block
    assert_equal 7, @collection.count { |x| x.even? || x % 3 == 0 }
  end

  def test_each_cons
    n = 6
    actual = []
    size = @collection.size
    @collection.each_cons(n) { |sub| actual << sub.include?(n) }

    assert_equal [true] * (size - n + 1), actual
  end

  def test_group_by
    assert_equal({ 1 => [1, 8], 2 => [2, 9], 3 => [3, 10], 4 => [4], 5 => [5],
                   6 => [6], 0 => [7] }, @collection.group_by { |el| el % 7 })
  end

  def test_min
    assert_equal 1, @collection.min
  end

  def test_min_with_block
    actual = Collection.new('Peter Pan', 'Donald Duck', 'Ron Jeremy',
                            'Snowwhite')
    assert_equal 'Ron Jeremy',
                 actual.min { |x, y| (x.length % 5) <=> (y.length % 5) }
  end

  def test_min_by
    actual = Collection.new('Peter Pan', 'Donald Duck', 'Ron Jeremy',
                            'Snowwhite')
    assert_equal 'Ron Jeremy',
                 actual.min_by { |x, y| (x.length % 5) <=> (y.length % 5) }
  end

  def test_max
    assert_equal 10, @collection.max
  end

  def test_max_with_block
    actual = Collection.new('Peter Pan', 'Donald Duck', 'Ron Jeremy',
                            'Snowwhite')
    assert_equal 'Peter Pan',
                 actual.max { |x, y| (x.length % 5) <=> (y.length % 5) }
  end

  def test_max_by
    actual = Collection.new('Peter Pan', 'Donald Duck', 'Ron Jeremy',
                            'Snowwhite')
    assert_equal 'Peter Pan',
                 actual.max_by { |x, y| (x.length % 5) <=> (y.length % 5) }
  end

  def test_minmax
    assert_equal [1, 10], @collection.minmax
  end

  def test_take
    assert_equal [1, 2, 3, 4], @collection.take(4)
  end

  def test_take_while
    assert_equal((1..5).to_a, @collection.take_while { |e| e < 6 })
  end

  def test_drop
    assert_equal((7..10).to_a, @collection.drop(6))
  end

  def test_drop_while
    assert_equal((7..10).to_a, @collection.drop_while { |e| e < 7 })
  end
end
