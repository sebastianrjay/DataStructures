# let dist be a 
  
    
#     {\displaystyle |V|\times |V|}
  
# {\displaystyle |V|\times |V|} array of minimum distances initialized to 
  
    
#     {\displaystyle \infty }
  
# \infty  (infinity)
# let next be a 
  
    
#     {\displaystyle |V|\times |V|}
  
# {\displaystyle |V|\times |V|} array of vertex indices initialized to null

# procedure FloydWarshallWithPathReconstruction ()
#    for each edge (u,v)
#       dist[u][v] ← w(u,v)  // the weight of the edge (u,v)
#       next[u][v] ← v
#    for k from 1 to |V| // standard Floyd-Warshall implementation
#       for i from 1 to |V|
#          for j from 1 to |V|
#             if dist[i][j] > dist[i][k] + dist[k][j] then
#                dist[i][j] ← dist[i][k] + dist[k][j]
#                next[i][j] ← next[i][k]

# procedure Path(u, v)
#    if next[u][v] = null then
#        return []
#    path = [u]
#    while u ≠ v
#        u ← next[u][v]
#        path.append(u)
#    return path

def floyd_warshall_algorithm(graph)
  distance, next_node = Hash.new(Float::INFINITY), {}

  graph.nodes.each do |node|
    distance[[node, node]] = 0
  end

  graph.edges.each do |edge|
    distance[[edge.origin, edge.destination]] = edge.value
    next_node[[edge.origin, edge.destination]] = edge.destination
  end

  graph.nodes.each do |k|
    graph.nodes.each do |i|
      graph.nodes.each do |j|
        if distance[[i, j]] > distance[[i, k]] + distance[[k, j]]
          distance[[i, j]] = distance[[i, k]] + distance[[k, j]]
          next_node[[i, j]] = next_node[[i, k]]
        end
      end
    end
  end

  next_node
end

def path(next_node, origin, destination)
  return [] if next_node[[origin, destination]].nil?
  path = [origin]
  while origin != destination
    origin = next_node[[origin, destination]]
    path << origin
  end

  path
end
