require_relative 'spec_helper'
require_relative '../lib/floyd_warshall_algorithm'

describe 'floyd_warshall_algorithm' do
  let(:graph) { DirectedGraph.new }
  before(:each) do
    instantiate_nodes
    create_edges(graph)
  end

  it 'should find the shortest path between all pairs of nodes' do
    # TO DO: validate output
    floyd_warshall_algorithm(graph)
  end
end
