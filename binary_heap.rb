class Heap
	def initialize(comparator)
		raise "Invalid comparator" unless [:<, :>].include?(comparator)
		@comparator = comparator
		@elements = []
	end

	def push(num)
		@elements << num
		heapify_up!
		num
	end

	def pop
		num = @elements.first
		heapify_down!
		num
	end

	private

	def heapify_up!
		idx = @elements.length - 1

		until (parent_index = parent_index(idx)) < 0
			if @elements[idx].send(@comparator, @elements[parent_index])
				swap_elements(idx, parent_index)
			else
				break
			end		

			idx = parent_index
		end
	end

	def heapify_down!
		swap_elements(0, @elements.length - 1)
		@elements.pop
		idx = 0

		until (swap_idx = heapify_down_child_swap_index(idx)) == -1
			if @elements[swap_idx].send(@comparator, @elements[idx])
				swap_elements(idx, swap_idx)
			else
				break
			end

			idx = swap_idx
		end
	end

	def swap_elements(idx1, idx2)
		@elements[idx1], @elements[idx2] = @elements[idx2], @elements[idx1]
	end

	def parent_index(child_idx)
		(child_idx - 1) / 2
	end

	def child_indexes(parent_idx)
		[(2 * parent_idx) + 1, (2 * parent_idx) + 2]
	end

	def heapify_down_child_swap_index(parent_idx)
		return -1 if child_indexes(parent_idx).last >= @elements.length
		element_picker = (@comparator == :> ? :max : :min)

		swapped_child = child_indexes(parent_idx)
			.map {|c_idx| @elements[c_idx] }
			.send(element_picker)

		child_indexes(parent_idx).find { |c_idx| @elements[c_idx] == swapped_child }
	end
end

class MaxHeap < Heap
	def initialize
		super(:>)
	end

	def max
		@elements.first
	end
end

class MinHeap < Heap
	def initialize
		super(:<)
	end

	def min
		@elements.first
	end
end
