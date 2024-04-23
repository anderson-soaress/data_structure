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

  def find_near(node)
    return node if node.left == nil
    find_near(node.left)
  end

  def remove(value, node=self.root, node_parent=nil)
    return nil if node == nil
    if value == node.data
      if !node.left && !node.right
        value < node_parent.data ?  node_parent.left = nil : node_parent.right = nil
        return
      elsif node.left && !node.right
        value < node_parent.data ? node_parent.left = node.left : node_parent.right = node.left
        return
      elsif node.right && !node.left
        value < node_parent.data ? node_parent.left = node.right : node_parent.right = node.right
        return
      else
        near_node = find_near(node.right)
        remove(near_node.data)
        return node.data = near_node.data
      end
    end

    value < node.data ? remove(value, node.left, node) : remove(value, node.right, node)
  end

  def find(value, node=self.root)
    if node == nil 
      return nil 
    elsif value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      return pretty_print(node)
    end
  end

  def level_order(queue = Array.new(1, self.root), noblock_array=[])
    current_node = queue.shift

    if block_given?  
      yield current_node 
    else
      noblock_array << current_node.data
    end

    queue << current_node.left if current_node.left != nil
    queue << current_node.right if current_node.right != nil

    if !queue.empty? && block_given?
      level_order(queue){|node| yield node} 
    elsif !queue.empty?
      level_order(queue, noblock_array)
      return noblock_array
    end
  end

  def inorder(node=self.root, inorder_array = [])
    if block_given? 
      inorder(node.left) {|node| yield node } if node.left != nil
      yield node
      inorder(node.right) {|node| yield node } if node.right != nil 
    else
      inorder(node.left, inorder_array) if node.left != nil
      inorder_array << node.data
      inorder(node.right, inorder_array) if node.right != nil 
      inorder_array
    end
  end

  def preorder(node=self.root, preorder_array = [])
    if block_given?
      yield node
      preorder(node.left) {|node| yield node} if node.left != nil
      preorder(node.right) {|node| yield node} if node.right != nil
    else
      preorder_array << node.data
      preorder(node.left, preorder_array) if node.left != nil
      preorder(node.right, preorder_array) if node.right != nil
      preorder_array
    end
  end

  def postorder(node=self.root, postorder_array = [])
    if block_given?
      postorder(node.left) {|node| yield node} if node.left != nil
      postorder(node.right) {|node| yield node}  if node.right != nil
      yield node
    else
      postorder(node.left, postorder_array) if node.left != nil
      postorder(node.right, postorder_array) if node.right != nil
      postorder_array << node.data
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right 
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end