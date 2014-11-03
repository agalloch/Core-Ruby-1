module MyEnumerable
  def map
    return each unless block_given?

    (res = []).tap { each { |el| res << yield(el) } }
  end

  def filter
    return each unless block_given?

    (res = []).tap { each { |el| res << el if yield el } }
  end

  def reject
    return each unless block_given?

    (res = []).tap { each { |el| res << el unless yield el } }
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

  def any?(&block)
    block ||= proc { |obj| obj }
    each { |el| return true if block.call el }

    false
  end

  def all?(&block)
    block ||= proc { |obj| obj }
    each { |el| return false unless block.call el }

    true
  end

  def each_cons(n)
    # Your code goes here.
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
end
