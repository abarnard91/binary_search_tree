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
    #find the node that is going to be deleted
    until current_node.nil? 
      if current_node.data > node
        prev_node = current_node
        current_node = current_node.left_child
        #puts "Going left current node is #{current_node.data} and prev_node is #{prev_node.data}"
      elsif current_node.data < node 
        prev_node = current_node
        current_node = current_node.right_child
        #puts "Going right current node is #{current_node.data} and prev_node is #{prev_node.data}"
      else
        break
      end
    end
    #puts current_node.data

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
        #puts "in the left child loop"
        #puts "prev node is #{next_biggest_node.data}"
        prev_nbn = next_biggest_node
        next_biggest_node = next_biggest_node.left_child
        #puts "next biggest node is #{next_biggest_node.data}"
      end
      #puts "current node is #{current_node.data} next biggest node is #{next_biggest_node.data}"
      next_biggest_node.left_child = current_node.left_child
      if current_node.right_child.data == next_biggest_node.data
        current_node.right_child = next_biggest_node.right_child
      else
        next_biggest_node.right_child = current_node.right_child
      end

      
      prev_nbn.left_child = nil unless prev_nbn.nil? #the unless is if the next biggest node doesn't have a left child
      #puts "prev_nbn.left_child  is #{prev_nbn.left_child}"
      
      unless prev_node.nil? #ie if the node deleted is the root

        if prev_node.left_child == current_node
          prev_node.left_child = next_biggest_node        

        elsif prev_node.right_child == current_node
          prev_node.right_child = next_biggest_node        
        end
      else
        @root = next_biggest_node
      end
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
        current_node = current_node.left_child
      elsif current_node.data < node 
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
  #explore node & add children to queue array in FIFO explore each child and add subsequent children to queue until queue empty
  def level_order
    queue = Array.new
    level_order_array = Array.new
    queue << @root
    until queue.empty?
      level_order_array << queue[0].data
      queue << queue[0].left_child unless queue[0].left_child.nil?
      queue << queue[0].right_child unless queue[0].right_child.nil?
      queue.shift
    end
    if block_given?
      level_order_array.each do |node|
        yield(node)
      end
    else
      #puts "#{level_order_array}"
      return level_order_array
    end

  end

  #Write #inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.
  #inorder: root -> left -> Right
  def inorder(node = @root, inorder_arr = [])
    if node.nil?
      return inorder_arr
    else 
      inorder(node.left_child, inorder_arr)
      inorder_arr << node.data
      inorder(node.right_child, inorder_arr)
    end
    if block_given?
      inorder_arr.each do |node|
        yield(node)
      end
    else
      return inorder_arr
    end
  end

  #preorder: left -> root -> right
  def preorder(node = @root, preorder_arr = [])
    if node.nil?
      return preorder_arr
    else 
      preorder_arr << node.data
      preorder(node.left_child, preorder_arr)
      preorder(node.right_child, preorder_arr)
    end
    if block_given?
      preorder_arr.each do |node|
        yield(node)
      end
    else 
      return preorder_arr
    end
  end
  
  #postorder: left -> right -> root
  def postorder(node = @root, postorder_arr = [])
    if node.nil?
      return postorder_arr
    else 
      postorder(node.left_child, postorder_arr)
      postorder(node.right_child, postorder_arr)
      postorder_arr << node.data
    end
    if block_given?
      postorder_arr.each do |node|
        yield(node)
      end
    else
      return postorder_arr
    end
  end

  #Write a #height method that accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.
  #ie height of Alex node is 3, height of Luna is 2, height of Andrew is 2, height of Odin is 1
  def height(node)
    found_node = self.find(node) #find the nodes location in the tree
    left = found_node.left_child
    right = found_node.right_child
    left_count =  0
    right_count = 0
    unless left.nil?
      left_count += 1
      until left.left_child.nil? && left.right_child.nil?
        if left.left_child.nil?
          left = left.right_child
        else
          left = left.left_child
        end
        left_count +=1
        # puts left
        # puts "left count is #{left_count}"
      end
    end
    unless right.nil?
      right_count += 1
      until right.left_child.nil? && right.right_child.nil? 
        if right.left_child.nil?
          right = right.right_child
        else
          right = right.left_child
        end
        right_count += 1
        # puts right
        # puts "right count is #{right_count}"
      end
    end

    if left_count >= right_count
      return left_count
    else
      return right_count
    end

  end

  #Write a #depth method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.
  #ie depth of Alex is 1, depth of Kelly is 4
  def depth(node)
    current_node = @root
    depth = 0

    until current_node.nil?
      
      if current_node.data > node
        current_node = current_node.left_child
      elsif current_node.data < node 
        current_node = current_node.right_child
      else
        break
      end
      depth += 1
    end
    if current_node.nil?
      return "Node not found"
    else
      return depth
    end
  end


  #Write a #balanced? method that checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.


  #Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.



  def pretty_print(node = @root, prefix = '', is_left = true)
     pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
     puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
     pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
