class Queue

  attr_accessor :arr
  
  def initialize
    @arr = []
  end

  def dequeue
    arr.shift
  end

  def enqueue(element)
    arr << element
  end

  def size
    arr.length
  end

  def to_s
    arr
  end
end