require './doubly_linked_list'

# All operations run in O(1) time

class StackQueue
  def initialize
    @list = DoublyLinkedList.new
  end

  def first
    @list.head && @list.head.value
  end

  def last
    @list.tail && @list.tail.value
  end

  def append(value)
    new_node = DoublyLinkedListNode.new(value)
    @list.append(new_node)

    value
  end

  def prepend(value)
    new_node = DoublyLinkedListNode.new(value)
    @list.prepend(new_node)

    value
  end

  def remove_first
    node_to_remove = @list.head
    @list.remove(node_to_remove)

    node_to_remove.value
  end

  def remove_last
    node_to_remove = @list.tail
    @list.remove(node_to_remove)

    node_to_remove.value
  end
end
