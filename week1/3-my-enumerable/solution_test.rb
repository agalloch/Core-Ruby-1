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
    assert_equal [2, 3, 4, 5, 6], Collection.new(*1..5).map(&:succ)
  end

  def test_filter
    assert_equal [1, 3, 5, 7, 9], @collection.filter(&:odd?)
  end

  def test_reject
    assert_equal [1, 3, 5, 7, 9], @collection.reject(&:even?)
  end

  def test_reduce_initial_and_block
    assert_equal 55, @collection.reduce(0) { |memo, item| memo + item }
  end

  def test_reduce_initial_and_symbol
    assert_equal (-3628800), @collection.reduce(-1, :*)
  end

  def test_reduce_symbol
    assert_equal (-53), @collection.reduce(:-)
  end

  def test_reduce_block
    assert_equal 385, @collection.reduce { |memo, item| memo + item**2 }
  end

  def test_reduce_symbol_and_block
    assert_equal 100, @collection.reduce(:+) { |memo, item| item**2 }
  end

  def test_reduce_no_params
    assert_equal 4, @collectino.reduce
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
end
