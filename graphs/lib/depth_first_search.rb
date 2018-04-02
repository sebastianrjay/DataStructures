require 'set'

def depth_first_search_from(node, visited_nodes, &visitation_callback)
  return if node.nil?
  visitation_callback.call(node)
  visited_nodes << node
  node.neighbors.each do |neighbor|
    unless visited_nodes.include?(neighbor)
      depth_first_search_from(neighbor, visited_nodes, &visitation_callback)
    end
  end
end

def depth_first_search(graph, &visitation_callback)
  visited_nodes = Set.new
  depth_first_search_from(graph.nodes.first, visited_nodes, &visitation_callback)
end
