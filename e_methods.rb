# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/CaseEquality
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a?(Array)
      result = []
      my_each { |value| result.push(value) if yield(value) }
    elsif is_a?(Range)
      result = []
      my_each { |value| result.push(value) if yield(value) }
    else
      result = {}
      my_each { |key, value| result[key] = value if yield(key, value) }
    end
    result
  end

  def my_all?(argum = nil)
    if block_given? && !argum.nil?
      puts 'warning: given block not used'
      my_each { |element| return false unless element.is_a? argum }
    elsif block_given?
      my_each { |element| return false unless yield(element) }
    elsif argum.nil?
      my_each { |element| return false if element.nil? || element === false }
    elsif !argum.nil? && (argum.is_a? Class)
      my_each { |element| return false unless element.is_a? argum }
    elsif !argum.nil? && argum.instance_of?(Regexp)
      my_each { |element| return false unless argum.match(element) }
    elsif !argum.nil?
      my_each { |element| return false unless element == argum }
    else
      my_each { |element| return false unless element }
    end
    true
  end

  def my_any?(argum = nil)
    if block_given? && !argum.nil? && argum.instance_of?(Regexp)
      puts 'warning: given block not used'
      my_each { |element| return true if argum.match(element) }
    elsif !argum.nil? && (argum.is_a? Class)
      puts 'warning: given block not used'
      my_each { |element| return true if element.is_a? argum }
    elsif block_given? && !argum.nil?
      puts 'warning: given block not used'
      my_each { |element| return true if element == argum }
    elsif block_given?
      my_each { |element| return true if yield(element) }
    elsif argum.nil?
      my_each { |element| return true if element.nil? || element == false }
    elsif !argum.nil? && argum.instance_of?(Regexp)
      my_each { |element| return true if argum.match(element) }
    elsif argum
      my_each { |element| return true if element == argum }
    else
      my_each { |element| return true if element }
    end
    false
  end

  def my_none?(argum = nil)
    if block_given? && !argum.nil?
      puts 'warning: given block not used'
      my_each { |element| return true unless element.is_a? argum }
    elsif is_a?(Range) && block_given?
      to_a.my_each { |element| return true if yield(element) == false }
    elsif block_given?
      to_a.my_each { |element| return true unless yield(element) == true }
    elsif argum.nil?
      my_each { |element| return false if element == true }
      my_each { |element| return true if element == false }
    elsif !argum.nil? && (argum.is_a? Class)
      my_each { |element| return true unless element.is_a? argum }
    elsif !argum.nil? && argum.instance_of?(Regexp)
      my_each { |element| return true unless argum.match(element) }
    elsif argum
      my_each { |element| return false if element == argum }
      my_each { |element| return true if element != argum }
    else
      my_each { |element| return true unless element }
    end
    false
  end

  def my_count(argum = nil)
    counter = 0
    if block_given?
      my_each { |element| counter += 1 if yield(element) == true }
    elsif argum
      my_each { |element| counter += 1 if element == argum }
    else
      my_each { |element| counter += 1 if element }
    end
    counter
  end

  def my_map(prc = nil)
    return to_enum(:my_map) unless block_given? || !prc.nil?

    new_arr = []
    if !prc.nil?
      to_a.my_each { |i| new_arr.push(prc.call(i)) }
    else
      to_a.my_each { |i| new_arr.push(yield(i)) }
    end
    new_arr
  end

  def my_inject(argum = nil, sym = nil)
    return 'LocalJumpError (block not given)' if !block_given? && !argum

    if !block_given?
      if argum && sym
        memo = argum
        to_a.my_each { |element| memo = memo.send(sym, element) }
      elsif argum
        memo = first
        to_a[1..to_a.length].my_each { |element| memo = memo.send(argum, element) }
      end
    elsif block_given? && argum
      memo = argum
      my_each { |element| memo = yield(memo, element) }
    else
      memo = first
      to_a[1..to_a.length].my_each { |element| memo = yield(memo, element) }
      memo
    end
    memo
  end
  # End of module
end

def multiply_els(arr)
  arr.my_inject { |memo, n| memo * n }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/CaseEquality
