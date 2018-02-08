require 'objspace'
require_relative '../doubly_linked_list/doubly_linked_list'

# Least Recently Used Cache
class LRUCache
  attr_reader :bytes, :max_bytes

  def initialize(max_bytes = 1000000)
    @bytes, @list, @nodes = 0, DoublyLinkedList.new, {}
    @max_bytes = max_bytes # 1 MB max size by default
  end

  def get(key) # Returns data stored under key
    return nil unless @nodes[key]

    node = @nodes[key]
    @list.remove(node)
    @list.prepend(node)
    data(node)
  end

  def keys
    @list.to_a.map {|node| node.value.first }
  end

  def newest # Returns [key, data] if present
    @list.head ? @list.head.value : nil
  end

  def oldest # Returns [key, data] if present
    @list.tail ? @list.tail.value : nil
  end

  def set(key, data) # Returns data set under key
    new_node = DoublyLinkedListNode.new([key, data])
    new_memory = contained_bytes(new_node)
    is_full = @bytes + new_memory > @max_bytes

    while is_full
      last_node = @list.tail
      freed_memory = contained_bytes(last_node)
      @list.remove(last_node)
      @nodes.delete(key(last_node))
      @bytes -= freed_memory
      is_full = @bytes + new_memory > @max_bytes
    end

    @list.prepend(new_node)
    @bytes += new_memory
    @nodes[key] = new_node
    data(new_node)
  end

  def values
    @list.to_a.map {|node| node.value.last }
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

    def contained_bytes(node)
      ObjectSpace.memsize_of(key(node)) + ObjectSpace.memsize_of(data(node))
    end

    def data(node)
      node.value.last
    end

    def key(node)
      node.value.first
    end
end
