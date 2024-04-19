require './linked_list.rb'

class HashMap 

  attr_accessor :buckets, :size, :capacity

  def initialize
    @buckets = Array.new(16)
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
    if size >= capacity*0.75
      self.size *= 2
    end
  end

  def has?(key, index=0)
    if buckets[index].hash == hash(key)
      return true
    elsif buckets[index] == nil
      return false
    else
      has?(key,index+1)
    end
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
  end

  def get(key)
    index = hash(key)%capacity
    raise IndexError if index.negative? || index >= @buckets.length

    buckets[index].get(key)
  end
  
  def remove(key)
    index = hash(key)%capacity
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if buckets[index].remove(key) == nil
    self.size -= 1
  end

  def length(index=0, lenght=0)
    if !(buckets[index] == nil)
      lenght += buckets[index].length
    elsif index > capacity
      return lenght
    end
    length(index+1, lenght)
  end

  def clear(index=0)
    return self.size = 0 if index > capacity
    self.buckets[index] = nil
    clear(index+1)
  end

  def keys(index=0, keys=[])
    if !(buckets[index] == nil)
      keys += buckets[index].get_key
    elsif index > capacity
      return keys
    end
    keys(index+1, keys)
  end

  def values(index=0, values=[])
    if !(buckets[index] == nil)
      values += buckets[index].get_value
    elsif index > capacity
      return values
    end
    values(index+1, values)
  end

  def entries(index=0, entries=[])
    if !(buckets[index] == nil)
      arr = []
      arr << buckets[index].get_key + buckets[index].get_value
      entries << arr
    elsif index > capacity
      return entries
    end
    entries(index+1, entries)
  end
end

class Bucket

  attr_accessor :list

  def initialize
    @list = LinkedList.new
  end

  def put(key, value)
     list.key?(key) ? list.change(key, value) : list.append(key, value)
  end

  def get(key)
    list.find(key)
  end

  def remove(key)
    list.remove(key)
  end

  def length
    list.size
  end

  def get_key
    list.get_key
  end

  def get_value
    list.get_value
  end
end

map = HashMap.new
map.set("Anderson","Soares")
map.set("Carlos", "Gabriel")
map.set("Junior", 2)
map.set("Almeida", "t")
map.set("Carla", "Andre")
map.set("Pedro", 3)
map.set("Jose", 24)
map.set("GUs",30)
p map
p map.length
p map.keys
p map.values
p map.entries