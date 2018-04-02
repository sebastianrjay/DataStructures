require 'set'

def breadth_first_search(graph, &visitation_callback)
  return if graph.nodes.none?
  nodes_to_visit, visited_nodes = Set.new([graph.nodes.first]), Set.new

  until nodes_to_visit.empty?
    current_node = nodes_to_visit.first
    nodes_to_visit.delete(current_node)
    visitation_callback.call(current_node)
    visited_nodes << current_node
    current_node.neighbors.each do |neighbor|
      nodes_to_visit << neighbor unless visited_nodes.include?(neighbor)
    end
  end
end
