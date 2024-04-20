class Bucket

  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def add_head(key, value)
    self.size += 1
    self.head = Node.new(key, value, nil)  
  end

  def put(key, value)
    self.key?(key) ? self.change(key, value) : self.append(key, value)
  end

  def append(key, value, node = self.head)
    if head == nil
      return add_head(key, value) 
    elsif node.next_node == nil
      self.size += 1
      return node.next_node = Node.new(key, value, nil)
    else
      append(key, value, node.next_node)
    end
  end

  def key?(key, node=self.head)
    if head == nil
      return false
    elsif node.key == key
      return true
    elsif node.next_node == nil
      return false
    else
      key?(key, node.next_node)
    end
  end

  def change(key, new_value, node=self.head)
    if node.key == key
      return node.value = new_value
    elsif node.next_node == nil
      return nil
    else
      change(key, new_value, node.next_node)
    end
  end

  def find(key, node=self.head)
    if node.key == key
      return node.value
    elsif node.next_node == nil
      return nil
    else
      find(key, node.next_node)
    end
  end

  def remove(key, node=self.head)
    if size == 1
      self.head = nil
      return self.size -= 1
    elsif size == 0 || node.next_node == nil
      return nil
    elsif node.next_node.key == key
      node.next_node = nil
      return self.size -= 1
    else
      remove(key, node.next_node)
    end
  end

  def get_keys(keys=[],node=self.head)
    return keys if node == nil
    keys << node.key
    get_keys(keys,node.next_node)
  end

  def get_values(values=[],node=self.head)
    return values if node == nil
    values << node.value
    get_values(values,node.next_node)
  end
end

class Node 

  attr_accessor :value ,:key, :next_node

  def initialize(key, value, next_node)
    @value = value
    @key = key
    @next_node = next_node
  end
end