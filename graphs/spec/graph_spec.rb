require_relative 'spec_helper'

def test_graph_class(graph_class, edge_class)
  describe graph_class do
    before(:all) do
      instantiate_nodes
      @nodes_arr = [@node1, @node2, @node3]
      @nodes_set = Set.new(@nodes_arr)
      @graph = graph_class.new(@nodes_set)
    end

    describe '#initialize(nodes = [])' do
      it 'should take an Array of nodes as input' do
        expect(graph_class.new(@nodes_arr).nodes).to eq(@nodes_set)
      end

      it 'should take a Set of nodes as input' do
        expect(graph_class.new(@nodes_set).nodes).to eq(@nodes_set)
      end

      it 'should raise an error unless input is of class Array or Set' do
        msg = "The node list passed to #{graph_class}#initialize" +
          " must be of class Array or Set"
        hash = { @node1 => true, @node2 => true, @node3 => true }
        expect { graph_class.new(hash) }.to raise_error(msg)
      end

      it 'should instantiate an empty edges hash' do
        expect(@graph.instance_variable_get(:@edges)).to eq({})
      end
    end

    describe '#add_node(node)' do
      it 'should return nil and not add the node if it is already included' do
        expect(@graph.add_node(@node2)).to eq(nil)
        expect(@graph.nodes.include?(@node2)).to eq(true)
      end

      it 'should add the node and return it, if it is not already included' do
        expect(@graph.nodes.include?(@node4)).to eq(false)
        expect(@graph.add_node(@node4)).to eq(@node4)
        expect(@graph.nodes.include?(@node4)).to eq(true)
      end
    end

    describe '#has_node?(node)' do
      it 'should return true if the graph contains the given node' do
        @graph.add_node(@node6)
        expect(@graph.has_node?(@node6)).to eq(true)
      end

      it 'should return false if the graph does not contain the given node' do
        expect(@graph.has_node?(@node5)).to eq(false)
      end
    end

    describe '#delete_edge(edge)' do
      it 'should delete the edge and return it, if it is included in #edges' do
        edge = @graph.find_edge_by_nodes(@node1, @node3)
        expect(@graph.delete_edge(edge)).to eq(edge)
      end

      it 'should return nil if the edge is not included in #edges' do
        edge = edge_class.new(@node1, @node4)
        expect(@graph.delete_edge(edge)).to eq(nil)
      end
    end
  end
end

test_graph_class(DirectedGraph, DirectedEdge)
test_graph_class(UndirectedGraph, UndirectedEdge)
