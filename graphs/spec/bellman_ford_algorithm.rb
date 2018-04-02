require_relative 'spec_helper'
require_relative '../lib/bellman_ford_algorithm'

describe 'bellman_ford_algorithm' do
  let(:graph) { DirectedGraph.new }
  before(:each) do
    instantiate_nodes
    create_edges(graph)
  end

  it 'should find the shortest paths from an origin node to all nodes' do
    # TO DO: validate output
    bellman_ford_algorithm(graph, graph.nodes.first).map(&:values)
  end
end
