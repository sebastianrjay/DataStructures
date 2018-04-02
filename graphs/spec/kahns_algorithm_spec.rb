require_relative 'spec_helper'
require_relative '../lib/kahns_algorithm'

describe 'kahns_algorithm topological sort' do
  let(:graph) { KahnDirectedGraph.new }
  before(:each) do
    instantiate_nodes
    create_edges(graph)
  end

  describe 'KahnDirectedGraph#head_nodes' do
    it 'should only contain all nodes without an incoming edge' do
      expect(graph.head_nodes.to_a).to eq([@node1, @node2])
    end
  end

  describe 'topological sort' do
    it 'outputs the nodes in topologically sorted order' do
      sorted_nodes = topological_sort(graph)
      expect(sorted_nodes).to eq([@node1, @node2, @node3, @node4, @node5, @node6])
    end
  end
end
