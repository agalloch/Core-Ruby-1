# Counts the frequency of each character in the given string.
def histogram(string)
  counters = Hash.new(0)
  return counters if string.nil?

  string.each_char do |ch|
    counters[ch] += 1
  end

  counters
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
  normalized = object.to_s.gsub(/\s+/, '').downcase
  return normalized == normalized.reverse
end

# Checks whether the one argument is an anagram of the other.
def anagram?(word, other)
  histogram(word.to_s.gsub(/\s+/, '')) == histogram(other.to_s.gsub(/\s+/, ''))
end