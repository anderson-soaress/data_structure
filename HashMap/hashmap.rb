require './linked_list.rb'

class HashMap 

  attr_accessor :buckets, :size, :capacity

  def initialize
    @buckets = Array.new(4)
    @size = 0
    @capacity = @buckets.length
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
      
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
      
    hash_code
  end

  def load_factor
    entries = self.entries
    self.buckets = Array.new(capacity*2)
    self.capacity = buckets.length
    self.size = 0

    for entrie in entries do
      self.set(entrie[0], entrie[1])
    end
  end

  def has?(key, index=0)
    if !(buckets[index] == nil)
      return true if buckets[index].key?(key)
    elsif index > capacity
      return false
    end
    has?(key, index+1)
  end

  def set(key, value)
    index = hash(key)%capacity
    raise IndexError if index.negative? || index >= @buckets.length

    if !(buckets[index] == nil)   
      buckets[index].put(key, value) 
    else
      self.size  += 1
      buckets[index] = Bucket.new 
      buckets[index].put(key, value)
    end  
    load_factor() if size >= capacity*0.75
  end

  def get(key)
    index = hash(key)%capacity
    raise IndexError if index.negative? || index >= @buckets.length

    buckets[index] == nil ? nil : buckets[index].find(key)
  end
  
  def remove(key)
    index = hash(key)%capacity
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if buckets[index].remove(key) == nil
    self.size -= 1
  end

  def length(index=0, length=0)
    if !(buckets[index] == nil)
      length += buckets[index].size
    elsif index > capacity
      return length
    end
    length(index+1, length)
  end

  def clear(index=0)
    return self.size = 0 if index > capacity
    self.buckets[index] = nil
    clear(index+1)
  end

  def keys(index=0, keys=[])
    if !(buckets[index] == nil)
      keys += buckets[index].get_keys
    elsif index > capacity
      return keys
    end
    keys(index+1, keys)
  end

  def values(index=0, values=[])
    if !(buckets[index] == nil)
      values += buckets[index].get_values
    elsif index > capacity
      return values
    end
    values(index+1, values)
  end

  def entries(index=0, entries=[])
    if !(buckets[index] == nil)
      arr = []
      arr += (buckets[index].get_keys + buckets[index].get_values)
      x = 0
      until x >= arr.length/2 do
        arr2=[]
        if arr.length > 2 
          arr2 << arr[x] << arr[x+arr.length/2]
          entries << arr2
        else
          entries << arr
          break
        end
        x += 1
      end
    elsif index > capacity
      return entries
    end
    entries(index+1, entries)
  end
end