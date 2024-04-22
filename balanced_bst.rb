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

  def build_tree(first = 0, last = sorted_array.length-1, array = sorted_array, root=nil)
    return if first > last

    array = array[first..last]

    array.length.even? ? data = array[array.length/2] : data = array[(array.length/2) + 0.5] if root == nil
      
    root = Node.new(data)

    root.left = build_tree(0, array.find_index(data)-1, array) if root.left == nil && data != nil

    root.right = build_tree(array.find_index(data)+1, last, array) if root.right == nil && data != nil

    return root
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right 
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}" if node.data != nil
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end