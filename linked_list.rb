class LinkedList

  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def add_head(value)
    self.size += 1
    self.head = Node.new(value, nil)  
  end

  def append(value, node = self.head)
    if head == nil
      return add_head(value) 
    elsif node.next_node == nil
      self.size += 1
      return node.next_node = Node.new(value, nil)
    else
      append(value, node.next_node)
    end
  end

  def prepend(value)
    return add_head(value) if head == nil
    self.size += 1
    self.head = Node.new(value, head)
  end

  def tail(node = self.head)
    return node if node.next_node == nil
    tail(node.next_node)
  end

  def at(index, node=self.head)
    if node == nil 
      return nil
    elsif index == 0
      return node
    else
      at(index-1, node.next_node)
    end
  end

  def pop(node = self.head)
    if self.size == 1
      self.size -= 1
      return self.head = nil 
    elsif node.next_node.next_node == nil
      self.size -= 1
      return node.next_node = nil
    else
      pop(node.next_node)
    end
  end

  def contains?(value, node=self.head)
    if node.value == value
      return true
    elsif node.next_node == nil
      return false
    else
      contains?(value, node.next_node)
    end
  end

  def find(value, node=self.head, index=0)
    if node.value == value
      return index
    elsif node.next_node == nil
      return nil
    else
      find(value, node.next_node, index+1)
    end
  end

  def to_s(node=self.head, s="")
    if size == 0
      return "nil"
    elsif node.next_node == nil
      return s += "( #{node.value} ) -> nil"
    else
      s += "( #{node.value} ) -> "
      to_s(node.next_node, s)
    end
  end

  def insert_at(value, index)
    if index == 0
      return self.prepend(value)
    elsif index == self.size-1
      return self.append(value)
    elsif index > self.size-1
      return nil
    else
      self.size += 1
      self.at(index-1).next_node = Node.new(value,self.at(index))
    end
  end

  def remove_at(index)
    if index == 0
      self.size -= 1
      return self.head = head.next_node
    elsif index == self.size-1
      return self.pop
    elsif index > self.size-1
      return nil
    else
      self.size -=1
      self.at(index-1).next_node = self.at(index).next_node
    end
  end
end

class Node 

  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end