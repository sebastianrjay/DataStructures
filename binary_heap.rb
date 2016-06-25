class BinaryHeap
	def initialize(comparator)
		raise "Invalid comparator" unless [:<, :>].include?(comparator)
		@comparator, @elements = comparator, []
	end

	def count
		@elements.length
	end

	def peek
		@elements.first
	end

	def pop
		val = @elements.first
		heapify_down!
		val
	end

	def push(val)
		@elements << val
		heapify_up!
		val
	end

	private

	def child_to_swap_index(parent_idx)
		[(2 * parent_idx) + 1, (2 * parent_idx) + 2]
			.select { |idx| idx < count }
			.send("#{@comparator == :> ? :max : :min}_by") { |idx| @elements[idx] }
	end

	def heap_condition_is_satisfied?(parent_idx, child_idx)
		@elements[parent_idx].send("#{@comparator}=", @elements[child_idx])
	end

	def heapify_down!
		swap_elements!(0, @elements.length - 1)
		@elements.pop
		parent_idx = 0

		until (child_to_swap_idx = child_to_swap_index(parent_idx)).nil?
			break if heap_condition_is_satisfied?(parent_idx, child_to_swap_idx)
				
			swap_elements!(parent_idx, child_to_swap_idx)
			parent_idx = child_to_swap_idx
		end
	end

	def heapify_up!
		child_idx = @elements.length - 1

		until (parent_idx = parent_index(child_idx)).nil?
			break if heap_condition_is_satisfied?(parent_idx, child_idx)

			swap_elements!(child_idx, parent_idx)	
			child_idx = parent_idx
		end
	end

	def parent_index(child_idx)
		child_idx > 0 ? (child_idx - 1) / 2 : nil
	end

	def swap_elements!(idx1, idx2)
		@elements[idx1], @elements[idx2] = @elements[idx2], @elements[idx1]
	end
end

class BinaryMaxHeap < BinaryHeap
	def initialize
		super(:>)
	end

	alias_method :max, :peek
end

class BinaryMinHeap < BinaryHeap
	def initialize
		super(:<)
	end

	alias_method :min, :peek
end
