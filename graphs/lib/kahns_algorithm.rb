require_relative './directed_graph'

# Modify the DirectedGraph to store @head_nodes, which have no incoming edge
class KahnDirectedGraph < DirectedGraph
  attr_reader :head_nodes

  def add_edge(edge)
    added_edge = super
    return if added_edge.nil?
    @head_nodes.delete(added_edge.destination)
    added_edge
  end

  def add_node(node)
    added_node = super
    @head_nodes ||= Set.new
    @head_nodes << added_node unless added_node.nil?
    added_node
  end

  # Now runs in O(edge_count) time, since we have to search for incoming edges
  def delete_edge_by_nodes(origin_node, destination_node)
    edge = super
    return if edge.nil?
    incoming_edges = @edges.select do |key, edge|
      edge.destination == destination_node
    end
    @head_nodes << destination_node if incoming_edges.none?
    edge
  end
end

# A topological sort algorithm

# L ← Empty list that will contain the sorted elements
# S ← Set of all nodes with no incoming edge
# while S is non-empty do
#     remove a node n from S
#     add n to tail of L
#     for each node m with an edge e from n to m do
#         remove edge e from the graph
#         if m has no other incoming edges then
#             insert m into S
# if graph has edges then
#     return error (graph has at least one cycle)
# else 
#     return L (a topologically sorted order)

def topological_sort(kahn_directed_graph)
  sorted_nodes = []

  until kahn_directed_graph.head_nodes.empty?
    current_node = kahn_directed_graph.head_nodes.first
    kahn_directed_graph.head_nodes.delete(current_node)
    sorted_nodes << current_node
    current_node.neighbors.each do |neighbor|
      kahn_directed_graph.delete_edge_by_nodes(current_node, neighbor)
    end
  end

  if kahn_directed_graph.edges.any?
    raise 'Cyclic graph cannot be topologically sorted'
  else
    return sorted_nodes
  end
end
