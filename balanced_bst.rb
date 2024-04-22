class Node

  attr_accessor :data, :right, :left

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree 

  attr_accessor :sorted_array, :root

  def initialize(array)
    @sorted_array = array.sort.uniq
    @root = build_tree
  end

  def build_tree(array = self.sorted_array, root=nil)
    if array.length <= 0
      return nil
    elsif array.length == 1
      return Node.new(array[0])
    else
      array.length.even? ? data = array[array.length/2] : data = array[(array.length/2) + 0.5] 

      root = Node.new(data)

      root.left = build_tree(array[0..array.find_index(data)-1]) if root.left == nil 

      root.right = build_tree(array[array.find_index(data)+1..array.length-1]) if root.right == nil 

      return root
    end
  end

  def insert(value, node = self.root)
    if value < node.data
      return node.left = Node.new(value) if node.left == nil
      insert(value, node.left)
    elsif value > node.data
      return node.right = Node.new(value) if node.right == nil
      insert(value, node.right)
    else
      return nil
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right 
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end