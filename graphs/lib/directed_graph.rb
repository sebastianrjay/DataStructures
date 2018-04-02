require 'adjacency_list_graph'
require 'directed_edge'
require 'node'
require 'set'

class DirectedGraph < AdjacencyListGraph
  def add_edge(edge)
    unless has_edge?(edge)
      origin, destination = edge.origin, edge.destination
      add_node(origin)
      add_node(destination)
      origin.add_neighbor(destination)
      @edges[generate_edge_key(origin, destination)] = edge
      edge
    end
  end

  def add_edge_by_nodes(origin_node, destination_node, value = 1)
    unless connected_nodes?(origin_node, destination_node)
      add_edge(DirectedEdge.new(origin_node, destination_node, value))
    end
  end

  def connected_nodes?(origin_node, destination_node)
    # O(1), since Node#neighbors is a Set
    origin_node.neighbors.include?(destination_node)
  end

  def delete_edge(edge)
    delete_edge_by_nodes(edge.origin, edge.destination) if edge
  end

  def delete_edge_by_nodes(origin_node, destination_node)
    origin_node.delete_neighbor(destination_node)
    @edges.delete(generate_edge_key(origin_node, destination_node))
  end

  def delete_node(node)
    # Runs in O(node.neighbors.count + graph.edges.count) time
    if @nodes.include?(node)
      @edges.values.each do |edge|
        delete_edge(edge) if edge.include?(node)
      end

      @nodes.delete(node)
      node
    end
  end

  def has_edge?(edge)
    graph_edge = find_edge_by_nodes(edge.origin, edge.destination)
    !!graph_edge && graph_edge.value == edge.value
  end
end
