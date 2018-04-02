require_relative 'spec_helper'
require_relative '../lib/breadth_first_search'
require_relative '../lib/depth_first_search'
require_relative '../lib/directed_graph'
require_relative '../lib/undirected_graph'

describe 'graph searches' do
  let(:directed_graph) { DirectedGraph.new }
  let(:undirected_graph) { UndirectedGraph.new }

  before do
    instantiate_nodes
  end

  [:directed_graph, :undirected_graph].each do |graph_name|
    let(:graph) { send(graph_name) }
    let(:nodes) { [] }

    before(:each) do
      create_edges(graph)
    end

    describe 'breadth_first_search' do
      it 'should traverse nodes in breadth first order' do
        breadth_first_search(graph) {|node| nodes << node}
        expect(nodes).to eq([@node1, @node3, @node4, @node2, @node5, @node6])
      end
    end

    describe 'depth_first_search' do
      it 'should traverse nodes in depth first order' do
        depth_first_search(graph) {|node| nodes << node}
        expect(nodes).to eq([@node1, @node3, @node2, @node4, @node5, @node6])
      end
    end
  end
end
