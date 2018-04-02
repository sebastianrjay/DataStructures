require 'set'


# It is an extension of Edsger Dijkstra's 1959 algorithm. A* achieves better 
# performance by using heuristics to guide its search.
def a_star_algorithm(graph, origin, destination)
    heuristic_distance_estimate = graph.edges.map(&:value).reduce(&:+)
    # Makes this no faster than Dijkstra implementation. Should vary by node
    heuristic_distance_to = Hash.new(heuristic_distance_estimate)
    visited_nodes, unvisited_nodes = Set.new, Set.new([origin])
    actual_distance, came_from = Hash.new(Float::INFINITY), {}
    actual_distance[origin] = 0
    heuristic_distance = Hash.new(Float::INFINITY)

    until unvisited_nodes.empty?
        current_node = unvisited_nodes.min_by {|node| heuristic_distance_to[node]}
        if current_node == destination
            return reconstruct_path(came_from, current_node) 
        end

        unvisited_nodes.delete(current_node)
        visited_nodes << current_node

        current_node.neighbors.each do |neighbor|
            next if visited_nodes.include?(neighbor)
            unvisited_nodes << neighbor unless unvisited_nodes.include?(neighbor)

            distance = graph.get_edge_value_by_nodes(current_node, neighbor)
            tentative_distance = actual_distance[current_node] + distance

            next if tentative_distance >= actual_distance[neighbor]

            came_from[neighbor] = current_node
            actual_distance[neighbor] = tentative_distance
            heuristic_distance_to[neighbor] =
                actual_distance[neighbor] + heuristic_distance_estimate
        end
    end

    raise "No path found from #{origin.value} -> #{destination.value}"
end

def reconstruct_path(came_from, current_node)
    path = [current_node]
    until came_from[current_node].nil?
        current_node = came_from[current_node]
        path << current_node
    end

    path.reverse
end
