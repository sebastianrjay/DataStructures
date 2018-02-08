require 'set'

class Node
  attr_accessor :value

  def initialize(value = 1)
    @value = value
    @neighbors = Set.new
  end

  def add_neighbor(node)
    @neighbors << node
  end

  def delete_neighbor(node)
    @neighbors.delete(node)
  end

  def get_edge_value(neighbor_node, graph)
    unless @neighbors.include?(neighbor_node)
      raise "Node passed to Node#get_edge_value is not a neighbor node"
    end

    graph.get_edge_value_by_nodes(self, neighbor_node)
  end

  def neighbors
    # Return a shallow copy so no one can accidentally modify the node's
    # neighbors; runs in O(node.neighbors.length) time.
    @neighbors.dup
  end
end
