require_relative 'spec_helper'
require_relative '../lib/a_star_algorithm'

describe 'a_star_algorithm' do
  let(:graph) { DirectedGraph.new }
  before(:each) do
    instantiate_nodes
    create_edges(graph)
  end

  it 'should find the shortest paths from an origin node to all nodes' do
    # TO DO: validate output
    p a_star_algorithm(graph, @node2, @node6).map(&:value)
  end
end
