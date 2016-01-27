require 'set'

module TreeConstructor
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

			current_node ||= BinarySearchTreeNode.new(sorted_array[mid_idx], parent_node)
			current_node.left = 
				build_min_depth_tree(sorted_array[0...mid_idx], current_node.left, current_node)
			current_node.right = 
				build_min_depth_tree(sorted_array[(mid_idx + 1)..-1], current_node.right, current_node)

			current_node
		end
end

module BreadthFirstTraversal
	def breadth_first_traversal(start_node = self, &block)
		node_queue, visited_nodes = [], Set.new
		node_queue.push(start_node)

		until node_queue.empty?
			current_node = node_queue.shift
			yield current_node

			if current_node.left && !visited_nodes.include?(current_node.left)
				visited_nodes << current_node.left
				node_queue << current_node.left
			end
			
			if current_node.right && !visited_nodes.include?(current_node.right)
				visited_nodes << current_node.right
				node_queue << current_node.right
			end
		end
	end
end

module DepthFirstTraversal
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
	extend TreeConstructor
	include BreadthFirstTraversal
	include DepthFirstTraversal

	attr_accessor :parent, :left, :right, :value

	def initialize(value, parent_node = nil)
		@parent = parent_node
		@value = value
		@left, @right = nil, nil
	end

	def find_node_by_value(val)
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
			@left = BinarySearchTreeNode.new(val, self)
		else
			@right = BinarySearchTreeNode.new(val, self)
		end
	end

	def remove(val, called_on_duplicate_value = false)
		# Removes and returns node with value val. If val is stored in more than one 
		# node instance, this method removes only the minimum-depth node instance.
		
		if called_on_duplicate_value
			node_to_delete = left.find_node_by_value(val)
		else
			node_to_delete = find_node_by_value(val)
		end

		return nil unless node_to_delete

		if !node_to_delete.left && !node_to_delete.right
			BinarySearchTreeNode.replace_node_with_other(node_to_delete, nil)
		elsif node_to_delete.left && node_to_delete.right
			in_order_predecessor = node_to_delete.left.right_most_leaf
			if node_to_delete.value == in_order_predecessor.value
				node_to_delete.remove(in_order_predecessor.value, true)
			else
				node_to_delete.remove(in_order_predecessor.value)
			end

			node_to_delete.value = in_order_predecessor.value
		else
			replacement_node = node_to_delete.left || node_to_delete.right
			replacement_node.parent = node_to_delete.parent
			BinarySearchTreeNode.replace_node_with_other(node_to_delete, replacement_node)
		end

		node_to_delete
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
			elsif node_to_delete == node_to_delete.parent.right
				node_to_delete.parent.right = replacement_node
			end
		end
end
