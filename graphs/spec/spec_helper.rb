require 'rspec'
require_relative '../lib/directed_graph'
require_relative '../lib/undirected_graph'

RSpec.configure do |c|
  c.color = true
end

def instantiate_nodes
	@node0 = Node.new
	@node1 = Node.new(4)
	@node2 = Node.new(5)
	@node3 = Node.new(6)
	@node4 = Node.new(7)
	@node5 = Node.new(8)
  @node6 = Node.new(9)
end

def create_edges(graph)
  graph.add_edge_by_nodes(@node1, @node3)
  graph.add_edge_by_nodes(@node1, @node4)
  graph.add_edge_by_nodes(@node4, @node5)
  graph.add_edge_by_nodes(@node5, @node6)
  graph.add_edge_by_nodes(@node2, @node3)
  graph.add_edge_by_nodes(@node2, @node4)
end
