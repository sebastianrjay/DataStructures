require_relative 'spec_helper'

describe UndirectedGraph do
	before(:all) do
		instantiate_nodes
		@nodes_arr = [@node1, @node2, @node3]
		@nodes_set = Set.new(@nodes_arr)
		@graph = UndirectedGraph.new(@nodes_set)
	end

	describe '#add_edge(edge)' do
		it 'should add the edge and return it, if it is not already included' do
			edge = UndirectedEdge.new(@node1, @node2)
			expect(@graph.add_edge(edge)).to eq(edge)
		end

		it 'should return nil and not add the edge if it is already included' do
			edge = UndirectedEdge.new(@node1, @node2)
			expect(@graph.add_edge(edge)).to eq(nil)
			expect(@graph.has_edge?(edge)).to eq(true)
		end
	end

	describe '#add_edge_by_nodes(node1, node2, val = nil)' do
		it 'should return nil and not add the edge if it is already included' do
			expect(@graph.add_edge_by_nodes(@node1, @node2, 5)).to eq(nil)
		end

		it 'should add the edge and return it, if it is not already included' do
			edge = @graph.add_edge_by_nodes(@node1, @node3, 6)
			expect(edge.include?(@node1)).to eq(true)
			expect(edge.include?(@node3)).to eq(true)
			expect(@graph.has_edge?(edge)).to eq(true)
		end
	end

	describe '#connected_nodes?(node1, node2)' do
		text = 'should return true for any two nodes linked by an edge,' +
			' regardless of the order in which they are passed to the method'
		it text do
			expect(@graph.connected_nodes?(@node1, @node2)).to eq(true)
			expect(@graph.connected_nodes?(@node2, @node1)).to eq(true)
			expect(@graph.connected_nodes?(@node3, @node1)).to eq(true)
			expect(@graph.connected_nodes?(@node1, @node3)).to eq(true)
		end

		it 'should return false for any two nodes not linked by an edge' do
			expect(@graph.connected_nodes?(@node2, @node3)).to eq(false)
			expect(@graph.connected_nodes?(@node4, @node6)).to eq(false)
		end

		it 'should return false when passed the same node in both arguments' do
			expect(@graph.connected_nodes?(@node1, @node1)).to eq(false)
			expect(@graph.connected_nodes?(@node4, @node4)).to eq(false)
		end
	end

	describe '#find_edge_by_nodes(node1, node2)' do
		text = 'should return the edge linking the two nodes, if the edge exists,' +
		' regardless of the order in which the nodes are passed to the method'
		it text do
			edge = UndirectedEdge.new(@node1, @node2)
			expect(@graph.find_edge_by_nodes(@node1, @node2).nodes.include?(@node1))
				.to eq(true)
			expect(@graph.find_edge_by_nodes(@node1, @node2).nodes.include?(@node2))
				.to eq(true)
			expect(@graph.find_edge_by_nodes(@node2, @node1).nodes.include?(@node1))
				.to eq(true)
			expect(@graph.find_edge_by_nodes(@node2, @node1).nodes.include?(@node2))
				.to eq(true)
		end

		it 'should return nil if the graph contains no edge linking the two nodes' do
			expect(@graph.find_edge_by_nodes(@node2, @node4)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node4, @node5)).to eq(nil)
		end
	end

	describe '#get_edge_value_by_nodes(node1, node2)' do
		text = 'should return the value of the edge linking the two nodes, if the' +
		' edge exists, regardless of the order in which the nodes are passed to ' +
		'the method'
		it text do
			expect(@graph.get_edge_value_by_nodes(@node1, @node2)).to eq(1)
			expect(@graph.get_edge_value_by_nodes(@node2, @node1)).to eq(1)
			expect(@graph.get_edge_value_by_nodes(@node1, @node3)).to eq(6)
			expect(@graph.get_edge_value_by_nodes(@node3, @node1)).to eq(6)
		end

		it 'should raise an error if no edge exists between the nodes given' do
			msg = "No UndirectedEdge exists between the origin and destination " +
				"nodes passed to UndirectedGraph#get_edge_value_by_nodes"
			expect { @graph.get_edge_value_by_nodes(@node5, @node6) }
				.to raise_error(msg)
		end
	end

	describe '#has_edge?(edge)' do
		it 'should return false if the graph does not contain the edge given' do
			edge = UndirectedEdge.new(@node2, @node3, 4)
			expect(@graph.has_edge?(edge)).to eq(false)
		end

		it 'should return false if the edge values do not match' do
			edge = UndirectedEdge.new(@node1, @node2, 4)
			expect(@graph.has_edge?(edge)).to eq(false)
		end

		requirement = 'should return true if the graph contains the edge given, ' +
		'regardless of the order in which the nodes are passed to ' +
		'UndirectedEdge#initialize'

		it requirement do
			edge1 = UndirectedEdge.new(@node1, @node2)
			edge2 = UndirectedEdge.new(@node2, @node1)
			edge3 = UndirectedEdge.new(@node1, @node3, 6)
			edge4 = UndirectedEdge.new(@node3, @node1, 6)
			expect(@graph.has_edge?(edge1)).to eq(true)
			expect(@graph.has_edge?(edge2)).to eq(true)
			expect(@graph.has_edge?(edge3)).to eq(true)
			expect(@graph.has_edge?(edge4)).to eq(true)
		end
	end

	describe '#delete_edge_by_nodes(node1, node2)' do
		it 'should delete the edge associated with the nodes, and return it' do
			edge = @graph.find_edge_by_nodes(@node1, @node2)
			expect(@graph.delete_edge_by_nodes(@node2, @node1)).to eq(edge)
			expect(@graph.has_edge?(edge)).to eq(false)
		end

		it 'should return nil if the edge is not included in #edges' do
			expect(@graph.delete_edge_by_nodes(@node5, @node1)).to eq(nil)
		end
	end

	describe '#set_edge_value_by_nodes(node1, node2, val)' do
		text = 'should set the value of the edge connecting the two nodes, ' +
			'regardless of the order in which they are passed to the method, ' +
			'and return the edge'
		it text do
			edge = UndirectedEdge.new(@node1, @node4, 2)
			@graph.add_edge(edge)
			expect(@graph.set_edge_value_by_nodes(@node4, @node1, 3)).to eq(edge)
			expect(edge.value).to eq(3)
			expect(@graph.set_edge_value_by_nodes(@node4, @node1, 4)).to eq(edge)
			expect(edge.value).to eq(4)
		end

		it 'should raise an error if no edge exists connecting the two nodes' do
			msg = "No UndirectedEdge exists between the origin and destination " + 
				"nodes passed to UndirectedGraph#set_edge_value_by_nodes"
      expect { @graph.set_edge_value_by_nodes(@node2, @node6, 8) }
      	.to raise_error(msg)
		end
	end

	describe '#delete_node(node)' do
		it 'should return nil if the Node is not present' do
			node = Node.new(9)
			expect(@graph.delete_node(node)).to eq(nil)
		end

		msg = 'should delete the Node and all of its associated edges and return the' +
			' Node, if the Node is included in the Graph' 

		it msg do
			expect(@graph.delete_node(@node1)).to eq(@node1)
			expect(@graph.find_edge_by_nodes(@node1, @node3)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node3, @node1)).to eq(nil)
		end
	end
end
