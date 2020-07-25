require_relative "node"

class Tree
  attr_reader :root

  def initialize(data)
    #sort and remove duplicates
    #call build_tree which returns root node
    @root = build_tree(data.sort.uniq)
  end

  def build_tree(data)
    #base cases
    return nil if data.empty?
    return Node.new(data[0]) if data.size == 1

    #get the middle of the array and make it the root node
    midpoint = data.size / 2
    root_node = Node.new(data[midpoint])

    #recursively do the same for the left and make it the left child of root
    root_node.left = build_tree(data[0..(midpoint - 1)])

    #recursively do the same for the right and make it the right child of root
    root_node.right = build_tree(data[(midpoint + 1)..(data.size - 1)])

    #return the root node
    root_node
  end

  def insert(value, node = root)   #recursive solution
    new_node = Node.new(value)

    if node.nil?                   #base cases
      node = new_node
    elsif new_node == node           #keep only one duplicate
      node = new_node
    else
      if new_node < node           #check left
        if node.left.nil?            #set value to left child if empty
          node.left = new_node
        else                            #otherwise set new node and repeat
          insert(value, node.left)
        end
      else                            #check right
        if node.right.nil?           #set value to right child if empty
          node.right = new_node
        else
          insert(value, node.right)  #otherwise set new node and repeat
        end
      end
    end
  end

  def delete(value, node = @root)
    #compare values and move left/right accordingly
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)

    #until value is found (gives error if value does not match)
    else
      if node.left.nil?         #check for one child node
        successor = node.right
        node = nil
        return successor
      elsif node.right.nil?
        successor = node.left
        node = nil
        return successor
      else                      #if node has two children
        successor = min_value(node.right)
        node.data = successor.data
        node.right = delete(successor.data, node.right)
      end
    end
    return node
  end

  def min_value(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def find(value)                      #iterative method
    node = root

    until node.data == value
      if value < node.data
        node = node.left
      else
        node = node.right
      end

      break if node.nil?
    end

    node
  end

  def level_order(node = @root, queue = [], order = [])
    queue << node
    until queue.empty?
      current = queue.first
      order << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      queue.delete(queue.first)
    end
    return order
  end

  def inorder
  end

  def preorder
  end

  def postorder
  end

  def depth
  end

  def balanced?
  end

  def rebalance
  end

  def pretty_print(node = root, prefix="", is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
      puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
      pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
    end

end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
puts tree.find(7).inspect
tree.insert(7)
tree.pretty_print
tree.delete(3)
tree.pretty_print
puts tree.level_order
