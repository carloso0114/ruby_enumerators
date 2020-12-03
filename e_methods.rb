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

    if is_a?(Array || Range)
      result = []
      my_each { |value| result.push(value) if yield(value) }
    else
      result = {}
      my_each { |key, value| result[key] = value if yield(key, value) }
    end
    result
  end

  def my_all?
    if block_given?
      my_each { |element| return false unless yield(element) }
    else
      my_each { |element| return false unless element }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |element| return true if yield(element) == true }
    else
      my_each { |element| return true if element }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |element| return false if yield(element) == true }
    else
      my_each { |element| return false if element }
    end
    true
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

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?
    new_arr = []
    if proc.nil?
      to_a.my_each { |i| new_arr.push(yield(i)) }
    else to_a.my_each { |i| new_arr.push(proc.call(i)) }
    end
    new_arr
  end

  def my_inject(argum = nil)
    memo = if !argum.nil?
             argum
           else
             first - first
           end
    my_each do |element|
      puts memo
      memo = yield(memo, element)
    end
    memo
  end

  # Method to multiply elements
  def my_inject1(argum = 1)
    memo = if !argum.nil?
             argum
           else
             first - first
           end
    my_each do |element|
      puts memo
      memo = yield(memo, element)
    end
    memo
  end
end

def multiply_els(ar)
  ar.my_inject1 { |memo, n| memo * n }
end

# rubocop:enable Style/CaseEquality
