require_relative 'spec_helper'

describe Node do
	before(:all) do
		instantiate_nodes
	end

	describe '#initialize' do
		text = 'sets the value as the passed argument, and sets @neighbors as an ' +
			'empty set of neighbor nodes'
		it text do
			expect(@node1.value).to eq(4)
			expect(@node1.neighbors).to eq(Set.new)
		end

		it 'sets the value as 1 when none is given' do
			expect(@node0.value).to eq(1)
			expect(@node0.neighbors).to eq(Set.new)
		end		
	end

	describe '#add_neighbor' do
		it 'adds a neighbor node' do
			@node1.add_neighbor(@node2)
			@node1.add_neighbor(@node3)

			expect(@node1.neighbors.include?(@node2)).to eq(true)
			expect(@node1.neighbors.include?(@node3)).to eq(true)
		end
	end

	describe '#delete_neighbor' do
		it 'deletes a neighbor node' do
			@node1.delete_neighbor(@node2)
			expect(@node1.neighbors.include?(@node2)).to eq(false)
		end
	end

	describe '#get_edge_value(neighbor_node, graph)' do
		it 'should return the edge value associated with a node and its neighbor' do
			graph = UndirectedGraph.new([@node1, @node2, @node3, @node4])
			graph.add_edge_by_nodes(@node1, @node3, 27)
			expect(@node3.get_edge_value(@node1, graph)).to eq(27)
			edge = UndirectedEdge.new(@node2, @node4, 16)
			graph.add_edge(edge)
			expect(@node2.get_edge_value(@node4, graph)).to eq(16)
		end

		it 'should raise an error if no edge exists between the two nodes' do
			graph = UndirectedGraph.new([@node1, @node2, @node3, @node4])
			msg = "Node passed to Node#get_edge_value is not a neighbor node"
			expect { @node3.get_edge_value(@node4, graph) }.to raise_error(msg)
		end
	end

	describe '#neighbors' do
		it 'should return a Set of Node instances' do
			expect(@node1.neighbors).to be_instance_of(Set)
			expect(@node1.neighbors.all? {|obj| obj.is_a? Node })
				.to eq(true)
		end

		it 'should return a deep copy of the Node\'s neighbors' do
			first_neighbor = @node1.neighbors.first
			@node1.neighbors.delete(first_neighbor)
			expect(@node1.neighbors.first).to eq(first_neighbor)
		end
	end
end
