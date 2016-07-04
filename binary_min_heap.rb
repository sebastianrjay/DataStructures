class BinaryMinHeap # The simplest possible binary min heap; stores values only
  def initialize
    @store = []
  end

  def count
    @store.length
  end

  def extract
    return nil if @store.empty?
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    self.class.heapify_down!(@store)
    val
  end

  def insert(val)
    @store << val
    self.class.heapify_up!(@store)
    val
  end

  def peek
    @store.first
  end

  def self.child_to_swap_index(array, parent_idx, length)
    # Returns the index of the smallest child in a min heap, or the index of the 
    # largest child in a max heap. Returns nil when parent_idx has no children
    [(2 * parent_idx) + 1, (2 * parent_idx) + 2].select { |idx| idx < length }
      .min_by { |idx| array[idx] }
  end

  def self.heapify_down!(array, length = array.length, parent_idx = 0)
    child_idx = child_to_swap_index(array, parent_idx, length)

    return array if child_idx.nil? || array[parent_idx] <= array[child_idx]

    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    parent_idx = child_idx

    heapify_down!(array, length, parent_idx)
  end

  def self.heapify_up!(array, child_idx = array.length - 1)
    parent_idx = (child_idx - 1) / 2

    return array if parent_idx < 0 || array[parent_idx] <= array[child_idx]

    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    child_idx = parent_idx

    heapify_up!(array, child_idx)
  end
end
