class LinkedList

  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def add_head(value)
    self.head = Node.new(value, nil)  
    self.size += 1
  end

  def append(value)
    return add_head(value) if head == nil

    node = head
    until node.next_node == nil do 
      node = node.next_node
    end
    node.next_node = Node.new(value, nil)
    self.size += 1
  end

  def prepend(value)
    return add_head(value) if head == nil

    self.head = Node.new(value, head)
    self.size += 1
  end

  def tail
    node = head
    until node.next_node == nil do 
      node = node.next_node
    end
    node
  end

  def at(index)
    node = head
    for i in (0..index-1) do 
      node = node.next_node
      return nil if node == nil
    end
    node
  end

  def pop
    node = head
    until node.next_node.next_node == nil do 
      node = node.next_node
    end
    node.next_node = nil
  end

  def contains?(value)
    node = head
    until node.next_node == nil do 
      node = node.next_node
      return true if node.value == value || head.value == value
    end

    false
  end

  def find(value)
    node = head
    index = 0
    until node.value == value do 
      node = node.next_node
      index += 1
      return nil if node == nil
    end
    index
  end

  def to_s
    s = "( #{head.value} ) -> "
    node = head
    until node.next_node == nil do
      node = node.next_node
      s += "( #{node.value} ) -> " 
    end
    s += "nil"
  end
end

class Node 

  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end