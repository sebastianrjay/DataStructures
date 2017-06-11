require 'set'

class DoublyLinkedListNode
	attr_accessor :next, :prev, :value

	def initialize(value)
		@value = value
	end
end

class DoublyLinkedList
	attr_accessor :head, :tail

	def initialize(node_values_array = [])
		@nodes, @node_value_counts, previous_node = Set.new, Hash.new(0), nil

		node_values_array.each_with_index do |node_value, i|
			current_node = DoublyLinkedListNode.new(node_value)
			@node_value_counts[node_value] += 1
			@nodes << current_node

			if previous_node
				current_node.prev = previous_node
				previous_node.next = current_node
			end

			@head = current_node if i == 0
			@tail = current_node if i == node_values_array.length - 1
			previous_node = current_node
		end
	end

	def append(node, append_to = @tail)
		return nil if @nodes.include?(node)
		@nodes << node
		@node_value_counts[node.value] += 1

		next_node = append_to.next unless append_to.nil?
		node.prev = append_to
		append_to.next = node unless append_to.nil?
		node.next = next_node unless next_node.nil?
		next_node.prev = node unless next_node.nil?

		@head = node if @head.nil?
		@tail = node if append_to == @tail

		node
	end

	def has_value?(value)
		@node_value_counts[value] > 0
	end

	def node_count(value = nil)
		# Returns the number of occurrences of a specific node value within the list
		# in O(1) time; returns the total number of nodes if no value is given.
		return @nodes.count unless value

		@node_value_counts[value]
	end

	def prepend(node)
		return nil if @nodes.include?(node)
		@nodes << node
		@node_value_counts[node.value] += 1

		node.next = head
		head.prev = node unless head.nil?
		@head = node

		node
	end

	def remove(node)
		return nil unless @nodes.include?(node)
		@node_value_counts[node.value] -= 1
		@nodes.delete(node)

		if node == tail
			node.prev.next = nil unless node.prev.nil?
			@tail = node.prev
			node.prev = nil
		elsif node == head
			@head = node.next
			node.next.prev = nil unless node.next.nil?
			node.next = nil
		else
			node.prev.next = node.next unless node.prev.nil?
			node.next.prev = node.prev unless node.next.nil?
		end

		node
	end

	def to_a
		as_array(false)
	end

	def values
		as_array(true)
	end

	private

		def as_array(values_only = false)
			array, current_node = [], head

			while current_node
				array << (values_only ? current_node.value : current_node)
				current_node = current_node.next
			end

			array
		end
end
