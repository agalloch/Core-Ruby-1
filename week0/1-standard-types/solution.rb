# Counts the frequency of each character in the given string.
def histogram(string)
  count string.split(/(?<=.)/)
end

# Checks whether its argument is a prime number.
def prime?(n)
  return false unless n.is_a?(Integer) && n > 0

  (2..Math.sqrt(n)).each do |k|
    return false if (n % k).zero?
  end

  true
end

def ordinal(n)
  return false unless n.is_a?(Integer)

  if (11..13).include?(n.abs % 100) then "#{n}th" # make Rubocop shut up
  else
    case (n.abs % 10)
    when 1 then "#{n}st"
    when 2 then "#{n}nd"
    when 3 then "#{n}rd"
    else "#{n}th"
    end
  end
end

# Checks whether its argument is a palindrome, ignoring any whitespaces.
def palindrome?(object)
  normalized = condense(object)
  normalized == normalized.reverse
end

# Checks whether the one argument is an anagram of the other.
def anagram?(word, other)
  histogram(condense(word)) == histogram(condense(other))
end

def remove_prefix(string, prefix)
  if string.start_with? prefix
    string.slice(prefix.size..-1).strip
  else
    string
  end
end

def remove_suffix(string, suffix)
  if string.end_with? suffix
    string.slice(0..-(suffix.size + 1)).strip
  else
    string
  end
end

def digits(n)
  n.to_s.split(/(?<=\d)/).map(&:to_i)
end

def fizzbuzz(range)
  result = []
  range.each do |el|
    result << :fizz if el % 3 == 0
    result << :buzz if el % 5 == 0
    result << el unless el % 3 == 0 || el % 5 == 0
  end

  result
end

class Array
  def to_hash
    result = {}
    each do |el|
      key, value = el
      result[key] = value
    end

    result
  end

  def index_by
    result = {}
    each do |el|
      result[el] = yield(el) if block_given?
    end

    result.invert
  end

  def subarray_count(subarray)
    return 0 unless subarray && subarray.size <= size

    this_array = join
    other_array = subarray.join
    count, index = 0, 0

    this_array.each_char do |_|
      break if (index..this_array.size).size < other_array.size
      count += 1 if this_array[index..-1].start_with? other_array
      index += 1
    end

    count
  end
end

def count(array)
  return {} unless array.is_a?(Array)

  result = Hash.new(0)
  array.each { |el| result[el] += 1 }
  result
end

def count_words(*sentences)
  count sentences.join.downcase.scan(/[a-z']+/)
end

# Helper method
def condense(string)
  string.to_s.gsub(/\s+/, '').downcase
end
