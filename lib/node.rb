#Build a Node class. It should have an attribute for the data it stores as well as its left and right children. As a bonus, try including the Comparable module and compare nodes using their data attribute.
class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child
  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
  
  def to_s
    "Sup this is your data: #{@data} "
  end
  
  def <=> (other)
    @data <=> other.data
  end  
  
end
