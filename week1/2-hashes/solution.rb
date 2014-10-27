class Hash
  def pick(*filter_set)
    select { |key, _| filter_set.include? key }
  end

  def except(*filter_set)
    reject { |key, _| filter_set.include? key }
  end

  def compact_values
    select { |_, value| true if value }
  end

  def defaults(other_hash)
    diff = other_hash.except(*keys)
    (result = Hash[self]).tap { diff.each { |k, v| result[k] = v } }
  end
end
