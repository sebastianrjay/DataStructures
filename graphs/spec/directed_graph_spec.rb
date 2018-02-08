require_relative 'spec_helper'

describe DirectedGraph do
	before(:all) do
		instantiate_nodes
		@nodes_arr = [@node1, @node2, @node3]
		@nodes_set = Set.new(@nodes_arr)
		@graph = DirectedGraph.new(@nodes_set)
	end

	describe '#add_edge(edge)' do
		it 'should add the edge and return it, if it is not already included' do
			edge = DirectedEdge.new(@node1, @node2)
			expect(@graph.add_edge(edge)).to eq(edge)
		end

		it 'should return nil and not add the edge if it is already included' do
			edge = DirectedEdge.new(@node1, @node2)
			expect(@graph.add_edge(edge)).to eq(nil)
			expect(@graph.has_edge?(edge)).to eq(true)
		end
	end

	describe '#add_edge_by_nodes(origin_node, destination_node, val = nil)' do
		it 'should return nil and not add the edge if it is already included' do
			expect(@graph.add_edge_by_nodes(@node1, @node2, 5)).to eq(nil)
		end

		it 'should add the edge and return it, if it is not already included' do
			edge = @graph.add_edge_by_nodes(@node1, @node3, 6)
			expect(edge.include?(@node1)).to eq(true)
			expect(edge.include?(@node3)).to eq(true)
			expect(@graph.has_edge?(edge)).to eq(true)
			edge2 = @graph.add_edge_by_nodes(@node3, @node1, 4)
			expect(edge2.include?(@node1)).to eq(true)
			expect(edge2.include?(@node3)).to eq(true)
			expect(@graph.has_edge?(edge2)).to eq(true)
		end
	end

	describe '#connected_nodes?(origin_node, destination_node)' do
		msg = 'should return true for any origin_node linked to a destination_node' +
		' in the graph, as long as the origin_node is passed as the first argument' +
		' and the destination_node is passed as the second argument'
		it msg do
			expect(@graph.connected_nodes?(@node1, @node2)).to eq(true)
			expect(@graph.connected_nodes?(@node2, @node1)).to eq(false)
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

	describe '#find_edge_by_nodes(origin_node, destination_node)' do
		it 'should return the edge linking the origin_node to the destination_node' do
			expect(@graph.find_edge_by_nodes(@node1, @node2).include?(@node1))
				.to eq(true)
			expect(@graph.find_edge_by_nodes(@node1, @node2).include?(@node2))
				.to eq(true)
		end

		it 'should return nil if the graph contains no edge linking the two nodes' do
			expect(@graph.find_edge_by_nodes(@node2, @node1)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node2, @node4)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node4, @node5)).to eq(nil)
		end
	end

	describe '#get_edge_value_by_nodes(node1, node2)' do
		text = 'should return the value of the edge linking the two nodes, if the' +
		' edge exists'
		it text do
			expect(@graph.get_edge_value_by_nodes(@node1, @node2)).to eq(1)
			expect(@graph.get_edge_value_by_nodes(@node3, @node1)).to eq(4)
		end

		it 'should raise an error if no edge exists between the nodes given' do
			msg = "No DirectedEdge exists between the origin and destination nodes " +
      "passed to DirectedGraph#get_edge_value_by_nodes"
			expect { @graph.get_edge_value_by_nodes(@node5, @node6) }
				.to raise_error(msg)
		end
	end

	describe '#has_edge?(edge)' do
		it 'should return false if the graph does not contain the edge given' do
			edge = DirectedEdge.new(@node2, @node3, 4)
			expect(@graph.has_edge?(edge)).to eq(false)
		end

		it 'should return false if the edge values do not match' do
			edge = DirectedEdge.new(@node1, @node2, 4)
			expect(@graph.has_edge?(edge)).to eq(false)
			edge2 = DirectedEdge.new(@node3, @node1, 6)
			expect(@graph.has_edge?(edge2)).to eq(false)
		end

		text = 'should be sensitive to the order in which the Nodes are passed to' +
		' DirectedEdge#initialize'

		it text do
			edge1 = DirectedEdge.new(@node1, @node2)
			edge2 = DirectedEdge.new(@node2, @node1)
			edge3 = DirectedEdge.new(@node1, @node3, 6)
			edge4 = DirectedEdge.new(@node3, @node1, 4)
			expect(@graph.has_edge?(edge1)).to eq(true)
			expect(@graph.has_edge?(edge2)).to eq(false)
			expect(@graph.has_edge?(edge3)).to eq(true)
			expect(@graph.has_edge?(edge4)).to eq(true)
		end
	end

	describe '#delete_edge_by_nodes(node1, node2)' do
		it 'should delete the edge associated with the nodes, and return it' do
			edge = @graph.find_edge_by_nodes(@node1, @node2)
			expect(@graph.delete_edge_by_nodes(@node1, @node2)).to eq(edge)
			expect(@graph.has_edge?(edge)).to eq(false)
		end

		it 'should return nil if the edge is not included in #edges' do
			expect(@graph.delete_edge_by_nodes(@node2, @node1)).to eq(nil)
			expect(@graph.delete_edge_by_nodes(@node5, @node1)).to eq(nil)
		end
	end

	describe '#set_edge_value_by_nodes(origin_node, destination_node, val)' do
		text = 'should set the value of the edge connecting the two nodes, ' +
			'if such an edge exists'
		it text do
			edge = DirectedEdge.new(@node1, @node4, 2)
			@graph.add_edge(edge)
			expect(@graph.set_edge_value_by_nodes(@node1, @node4, 3)).to eq(edge)
			expect(edge.value).to eq(3)
			expect(@graph.set_edge_value_by_nodes(@node1, @node4, 4)).to eq(edge)
			expect(edge.value).to eq(4)
		end

		it 'should raise an error if no edge exists connecting the two nodes' do
			msg = "No DirectedEdge exists between the origin and destination nodes " +
      "passed to DirectedGraph#set_edge_value_by_nodes"
      expect { @graph.set_edge_value_by_nodes(@node4, @node1, 8) }
      	.to raise_error(msg)
      expect { @graph.set_edge_value_by_nodes(@node2, @node6, 8) }
      	.to raise_error(msg)
		end
	end

	describe '#delete_node(node)' do
		it 'should return nil if the Node is not present' do
			node = Node.new(9)
			expect(@graph.delete_node(node)).to eq(nil)
		end

		msg = 'should delete the Node and all of its associated edges and return ' +
			'the Node, if the Node is included in the Graph. Should also work on ' + 
			'edges where the Node being deleted is the destination_node' 

		it msg do
			node = @graph.delete_node(@node1)
			expect(node).to eq(@node1)
			expect(@graph.find_edge_by_nodes(@node1, @node3)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node3, @node1)).to eq(nil)
			expect(@graph.find_edge_by_nodes(@node1, @node2)).to eq(nil)
		end
	end
end
