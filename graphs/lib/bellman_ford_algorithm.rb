# "The Bellman–Ford algorithm is an algorithm that computes shortest paths from  
# a single source vertex to all of the other vertices in a weighted digraph."
# - Wikipedia
def bellman_ford_algorithm(graph, origin_node)
  distance, predecessor = Hash.new(Float::INFINITY), {}
  distance[origin_node] = 0

  # Compute edge distances
  graph.nodes.each do |node|
    graph.edges.each do |edge|
      origin, destination = edge.origin, edge.destination
      if distance[origin] + edge.value < distance[destination]
        distance[destination] = distance[origin] + edge.value
        predecessor[destination] = origin
      end
    end
  end

  # Check for negative-weight cycles
  graph.edges.each do |edge|
    origin, destination = edge.origin, edge.destination
    if distance[origin] + edge.value < distance[destination]
      raise "Graph contains negative-weight cycle near #{origin.value} -> #{destination.value}"
    end
  end

  [distance, predecessor]
end
