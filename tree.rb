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

  def insert(value, pointer = root)
    new_node = Node.new(value)

    if pointer.nil?                   #base case
      pointer = new_node
    else
      if new_node < pointer           #check left
        if pointer.left.nil?            #set value to left child if empty
          pointer.left = new_node
        else                            #otherwise set new pointer and repeat
          insert(value, pointer.left)
        end
      else                            #check right
        if pointer.right.nil?           #set value to right child if empty
          pointer.right = new_node
        else
          insert(value, pointer.right)  #otherwise set new pointer and repeat
        end
      end
    end
  end

  def delete(value)
  end

  def find(value)
    pointer = root

    until pointer.data == value
      if value < pointer.data
        pointer = pointer.left
      else
        pointer = pointer.right
      end

      break if pointer.nil?
    end

    pointer
  end

  def level_order
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
tree.insert(21)
tree.pretty_print
