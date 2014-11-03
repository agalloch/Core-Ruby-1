class Array
  def to_hash
    (res = {}).tap { map { |x, y| res[x] = y } }
  end

  def index_by
    (res = {}).tap { each { |el| res[el] = yield(el) } }.invert
  end

  def occurences_count
    (res = Hash.new(0)).tap { each { |el| res[el] += 1 } }
  end

  def subarray_count(sub)
    count = 0
    return count if sub.nil? || size < sub.size

    each_with_index do |_, index|
      count += 1 if sub == slice(index, sub.size)
    end

    count
  end
end
