class Stack

  attr_accessor :arr

  def initialize
    @arr = []
  end

  def push(element)
    arr.push(element)
  end

  def pop
    arr.pop
  end

  def size
    arr.length
  end

  def to_s
    arr
  end
end