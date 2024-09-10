#Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute, which uses the return value of #build_tree which you’ll write next.

class Tree
  attr_accessor :root
  
  def initialize
    @root = nil
  end
  
  def sac(array) #sort and compact array to sort, remove duplicates, and remove nils
    array.uniq!
    array.compact!
    array.sort!
  end
  #build_tree method which takes an array of data (e.g., [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-0 root node.
  def build_tree(array, start = 0, last = (array.length-1))
    return nil if array.empty? 
    #puts "start is #{start} and last is #{last}"
    return nil if (start > last) 

    mid = (start + last) / 2
    node = nil
    node = Node.new(array[mid])
    @root =  node if @root.nil?
    #puts node

    node.left_child = build_tree(array, start, (mid - 1))

    node.right_child = build_tree(array, (mid + 1), last)

    node
   
  end

  #insert and #delete method which accepts a value to insert/delete. You’ll have to deal with several cases for delete, such as when a node has children or not. If you need additional resources, check out these two articles on inserting and deleting, or this video on BST inserting/removing with several visual examples.

  def insert(data)
    new_node = Node.new(data)
    return "node already exists" if new_node.data == @root.data
    current_node = @root
    
    until current_node.nil?
      prev_node = current_node
      if current_node.data > data
        current_node = current_node.left_child
      elsif current_node.data < data 
        current_node = current_node.right_child
      end
    end
    if prev_node.data > data
      prev_node.left_child = new_node
    else
      prev_node.right_child = new_node
    end
  end

  def delete(node)
    
    current_node = @root
    
    until current_node.nil?
      if current_node.data > node
        prev_node = current_node
        current_node = current_node.left_child
        puts "Going left current node is #{current_node.data} and prev_node is #{prev_node.data}"
      elsif current_node.data < node 
        prev_node = current_node
        current_node = current_node.right_child
        puts "Going right current node is #{current_node.data} and prev_node is #{prev_node.data}"
      else
        break
      end
    end
    #deletion at end node
    if current_node.left_child.nil? && current_node.right_child.nil?
      if prev_node.left_child == current_node
        prev_node.left_child = nil
      elsif prev_node.right_child == current_node
       prev_node.right_child = nil
      end
      current_node = nil

      
     #deletion at branch with two children 
    elsif (current_node.left_child.nil? == false && current_node.right_child.nil? == false)
      next_biggest_node = current_node.right_child
      
      until next_biggest_node.left_child.nil?
        puts "in the left child loop"
        puts next_biggest_node
        prev_nbn = next_biggest_node
        next_biggest_node = next_biggest_node.left_child
        puts next_biggest_node
      end
      next_biggest_node.left_child = current_node.left_child
      next_biggest_node.right_child = current_node.right_child

      prev_nbn.left_child = nil
      puts "prev_nbn.left_child  is #{prev_nbn.left_child}"

      # if prev_node.left_child == current_node
      #   current_node_replacement = current_node.left_child
      #   prev_node.left_child = current_node_replacement        
      #   current_node_replacement.right_child = current_node.right_child
      # elsif prev_node.right_child == current_node
      #   current_node_replacement = current_node.left_child
      #   prev_node.right_child = current_node_replacement        
      #   current_node_replacement.right_child = current_node.right_child
      # end
      current_node = nil

      
      #deletion if node only has one child
    else 
      if prev_node.left_child == current_node
        if current_node.left_child.nil?
          prev_node.left_child = current_node.right_child
        elsif current_node.right_child.nil?
          prev_node.left_child = current_node.left_child
        end
      elsif prev_node.right_child == current_node
        if current_node.left_child.nil?
          prev_node.right_child = current_node.right_child
        elsif current_node.right_child.nil?
          prev_node.right_child = current_node.left_child
        end
      end
      current_node = nil
    end 
  end
               

  #find method which accepts a value and returns the node with the given value.

  def find(node)

    current_node = @root

    until current_node.nil?
      
      if current_node.data > node
        previous_node = current_node
        current_node = current_node.left_child
      elsif current_node.data < node 
        previous_node = current_node
        current_node = current_node.right_child
      else
        break
      end
    end
    if current_node.nil?
      return "Node not found"
    else
      return current_node
    end
  end

  #Write a #level_order method which accepts a block. This method should traverse the tree in breadth-first level order and yield each node to the provided block. This method can be implemented using either iteration or recursion (try implementing both!). The method should return an array of values if no block is given. Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse, and to add new ones to the list (video on level order traversal).

  #Write #inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.

  #Write a #height method that accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

  #Write a #depth method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

  #Write a #depth method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

  #Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.



  def pretty_print(node = @root, prefix = '', is_left = true)
     pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
     puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
     pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
