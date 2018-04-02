require 'adjacency_list_graph'
require 'undirected_edge'
require 'node'
require 'set'

class UndirectedGraph < AdjacencyListGraph
  def add_edge(edge)
    unless has_edge?(edge)
      node1, node2 = edge.nodes[0], edge.nodes[1]
      add_node(node1)
      add_node(node2)
      node1.add_neighbor(node2)
      node2.add_neighbor(node1)
      @edges[generate_edge_key(node1, node2)] = edge
      edge
    end
  end

  def add_edge_by_nodes(node1, node2, value = 1)
    unless connected_nodes?(node1, node2)
      add_edge(UndirectedEdge.new(node1, node2, value))
    end
  end

  def connected_nodes?(node1, node2)
    # O(1), since Node#neighbors is a Set
    node1.neighbors.include?(node2) && 
      node2.neighbors.include?(node1)
  end

  def delete_edge(edge)
    delete_edge_by_nodes(edge.nodes[0], edge.nodes[1]) if edge
  end

  def delete_edge_by_nodes(node1, node2)
    node1.delete_neighbor(node2)
    node2.delete_neighbor(node1)
    @edges.delete(generate_edge_key(node1, node2)) ||
      @edges.delete(generate_edge_key(node2, node1))
  end

  def delete_node(node)
    # Runs in O(node.neighbors.count) time
    if @nodes.include?(node)
      node.neighbors.each do |neighbor_node| 
        delete_edge_by_nodes(node, neighbor_node)
      end
      @nodes.delete(node)
      node
    end
  end

  def has_edge?(edge)
    graph_edge = find_edge_by_nodes(edge.nodes[0], edge.nodes[1])
    !!graph_edge && edge.value == graph_edge.value
  end
end
