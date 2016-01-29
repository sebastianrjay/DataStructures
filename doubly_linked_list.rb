require 'set'

class DoublyLinkedListNode
	attr_accessor :next, :prev
	attr_reader :value

	def initialize(value)
		@value = value
	end
end

class DoublyLinkedList
	attr_accessor :head, :tail

	def initialize(node_values_array)
		@nodes, @node_value_counts, previous_node = Set.new, Hash.new(0), nil

		node_values_array.each_with_index do |node_value, i|
			current_node = DoublyLinkedListNode.new(node_value)
			@nodes << current_node

			if i == 0
				@head = current_node
			elsif i == node_values_array.length - 1
				@tail = current_node
			end

			if previous_node
				current_node.prev = previous_node
				previous_node.next = current_node
			end

			@node_value_counts[node_value] += 1	
			previous_node = current_node
		end
	end

	def node_count(value = nil)
		# Counts the number of occurrences of a specific node value within the list
		# in O(1) time; counts the total number of nodes if no value is given.
		return @nodes.count unless value

		@node_value_counts[value]
	end

	def remove(node)
		return nil unless @nodes.include?(node)
		@node_value_counts[node.value] -= 1
		@nodes.delete(node)

		if node == tail
			node.prev.next = nil
			@tail = node.prev
			node.prev = nil
		elsif node == head
			@head = node.next
			node.next.prev = nil
			node.next = nil
		else
			node.prev.next = node.next
			node.next.prev = node.prev
		end

		node
	end

	def to_a
		array, current_node = [], head

		while current_node
			array << current_node
			current_node = current_node.next
		end

		array
	end
end
