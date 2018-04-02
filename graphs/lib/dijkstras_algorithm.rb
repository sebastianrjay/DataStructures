require 'directed_graph'
require 'undirected_graph'

# Returns an array of nodes whose order reflects the shortest path from the 
# origin_node to the destination_node. 
def dijkstra_shortest_path(origin_node, destination_node, graph)
  return [] if origin_node == destination_node
  distance_from_origin_node, previous_node, shortest_path = {}, {}, []

  graph.nodes.each { |node| distance_from_origin_node[node] = Float::INFINITY }
  distance_from_origin_node[origin_node] = 0
  unchecked_nodes = distance_from_origin_node.dup

  until unchecked_nodes.empty?
    nearest_unchecked_node = unchecked_nodes.min_by { |node, dist| dist }.first
    unchecked_nodes.delete(nearest_unchecked_node)

    break if nearest_unchecked_node == destination_node

    nearest_unchecked_node.neighbors.each do |neighbor_node|
      distance_to_neighbor = distance_from_origin_node[nearest_unchecked_node] + 
        nearest_unchecked_node.get_edge_value(neighbor_node, graph)

      if distance_to_neighbor < distance_from_origin_node[neighbor_node]
        distance_from_origin_node[neighbor_node] = distance_to_neighbor
        unchecked_nodes[neighbor_node] = distance_to_neighbor
        previous_node[neighbor_node] = nearest_unchecked_node
      end
    end
  end

  shortest_path << (this_node = destination_node)
  until this_node == origin_node
    # Use push (O(1) amortized) instead of unshift (O(n))
    this_node = previous_node[this_node]
    shortest_path << this_node
  end

  shortest_path.reverse
end
