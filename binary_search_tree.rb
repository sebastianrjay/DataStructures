module ArrayConstructor
	def from_array(array)
		build_min_depth_tree(array.sort)
	end

	def from_sorted_array(sorted_array)
		build_min_depth_tree(sorted_array)
	end

	private
	
		def build_min_depth_tree(sorted_array, current_node = nil, parent_node = nil)
			# Builds the minimum-depth binary search tree corresponding to sorted_array
			return nil if sorted_array.empty?

			mid_idx = sorted_array.length / 2

			current_node ||= BinarySearchTreeNode.new(sorted_array[mid_idx])
			current_node.left = 
				build_min_depth_tree(sorted_array[0...mid_idx], current_node.left, current_node)
			current_node.right = 
				build_min_depth_tree(sorted_array[(mid_idx + 1)..-1], current_node.right, current_node)

			current_node
		end
end

module BreadthFirstSearch
	def breadth_first_traversal(node = self, &block)
		node_queue = []
	end
end

module DepthFirstSearch
	# Each of these can start at an arbitrary node within the tree

	def in_order_traversal(node = self, &block)
		if node.left
			in_order_traversal(node.left, &block) 
		end

		yield node

		if node.right
			in_order_traversal(node.right, &block)
		end
	end

	def post_order_traversal(node = self, &block)
		if node.left
			pre_order_traversal(node.left, &block) 
		end

		if node.right
			pre_order_traversal(node.right, &block)
		end

		yield node
	end

	def pre_order_traversal(node = self, &block)
		yield node

		if node.left
			pre_order_traversal(node.left, &block) 
		end

		if node.right
			pre_order_traversal(node.right, &block)
		end
	end
end

class BinarySearchTreeNode
	extend ArrayConstructor
	include BreadthFirstSearch
	include DepthFirstSearch

	attr_accessor :parent, :left, :right, :value

	def initialize(value, parent = nil)
		@parent = parent
		@value = value
		@left, @right = nil, nil
	end

	def find_node_by_value(val)
		# Return statements are unneeded because the contents of each if statement 
		# is the last line evaluated, when that if statement is triggered. If no if 
		# statement is triggered, the method returns nil because the last line is 
		# empty.
		if val == value
			self
		elsif left && val < value
			left.find_node_by_value(val)
		elsif right && val > value
			right.find_node_by_value(val)
		end
	end

	def insert(val)
		# Returns the new node corresponding to the inserted value
		if left && val <= value
			left.insert(val)
		elsif right && val > value
			right.insert(val)
		elsif val <= value
			@left = BinarySearchTreeNode.new(val)
		else
			@right = BinarySearchTreeNode.new(val)
		end
	end

	def left_most_leaf
		return self unless left

		left.left_most_leaf
	end

	def right_most_leaf
		return self unless right

		right.right_most_leaf
	end

	private

		def self.replace_node_with_other(node_to_delete, replacement_node)
			if node_to_delete == node_to_delete.parent.left
				node_to_delete.parent.left = replacement_node
				return node_to_delete
			elsif node_to_delete == node_to_delete.parent.left
				node_to_delete.parent.right = replacement_node
				return node_to_delete
			end
		end
end
