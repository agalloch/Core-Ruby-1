require 'pry'

module MyEnumerable
  def map
    return each unless block_given?

    [].tap { |res| each { |el| res << yield(el) } }
  end

  def filter
    return each unless block_given?

    [].tap { |res| each { |el| res << el if yield el } }
  end

  def reject
    return each unless block_given?

    [].tap { |res| each { |el| res << el unless yield el } }
  end

  def reduce(initial = nil, symbol = nil)
    if !block_given? || symbol
      if symbol.nil?
        symbol = initial
        initial = nil
      end

      symbol = symbol.to_sym

      each do |el|
        if initial.nil?
          initial = el
        else
          initial = initial.send(symbol, el)
        end
      end
    else
      each do |el|
        if initial.nil?
          initial = el
        else
          initial = yield(initial, el)
        end
      end
    end

    initial
  end

  alias_method :collect, :map
  alias_method :select, :filter
  alias_method :fold, :reduce

  def any?(&block)
    block ||= proc { |obj| obj }
    each { |el| return true if block.call el }

    false
  end

  def one?
    memo = false
    each do |el|
      p = block_given? ? yield(el) : el

      return false if p && memo

      memo = true if p
    end

    memo
  end

  def all?(&block)
    block ||= proc { |obj| obj }
    each { |el| return false unless block.call el }

    true
  end

  def each_cons(n)
    return nil if n > size || n <= 0
    return each unless block_given?

    sub = []
    each do |el|
      sub << el
      sub.shift if sub.size > n
      yield sub.dup if sub.size == n
    end

    nil
  end

  def include?(element)
    each { |el| return true if el == element }

    false
  end

  # FIXME: how to count 'nil' elements?
  def count(element = nil)
    count = 0

    if element
      each { |el| count += 1 if el == element }
    elsif block_given?
      each { |el| count += 1 if yield el }
    else
      count = size
    end

    count
  end

  def size
    each.size
  end

  def group_by
    return each unless block_given?

    groups = {}

    each do |el|
      factor = yield(el)

      if groups[factor]
        groups[factor] << el
      else
        groups[factor] = [el]
      end
    end

    groups
  end

  def min(&block)
    comp = block_given? ? block : -> x, y { x <=> y }

    res = each.peek
    each do |el|
      res = el if comp.call(el, res) < 0
    end

    res
  end

  def min_by(&block)
    return each unless block_given?

    min(&block)
  end

  def max(&block)
    comp = block_given? ? block : -> x, y { x <=> y }

    res = each.peek
    each do |el|
      res = el if comp.call(el, res) > 0
    end

    res
  end

  def max_by(&block)
    return each unless block_given?

    max(&block)
  end

  def minmax(&block)
    comp = block_given? ? block : -> x, y { x <=> y }

    min = max = each.peek
    each do |el|
      min = el if comp.call(el, min) < 0
      max = el if comp.call(el, max) > 0
    end

    [min, max]
  end

  def minmax_by(&block)
    return each unless block_given?

    minmax(&block)
  end

  def take(n)
    fail ArgumentError, "Cannot take #{n} items from collection" if n.to_i < 0

    [].tap do |res|
      each do |el|
        break if res.size == n.to_i
        res << el
      end
    end
  end

  def take_while
    return each unless block_given?

    [].tap do |res|
      each do |el|
        break unless yield el
        res << el
      end
    end
  end

  def drop(n)
    fail ArgumentError, "Cannot drop #{n} items from collection" if n.to_i < 0

    index = 0
    [].tap do |res|
      each do |el|
        res << el if index >= n
        index += 1
      end
    end
  end

  def drop_while
    return each unless block_given?

    [].tap do |res|
      each do |el|
        res << el unless yield el
      end
    end
  end
end
