require_relative '../lib/dijkstras_algorithm'

describe 'dijkstras_algorithm' do
	node1, node2, node3, node4 = Node.new, Node.new(2), Node.new(3), Node.new(4)
	node5, node6, node7, node8 = Node.new(5), Node.new(6), Node.new(7), Node.new(8)
	node_array1 = [node1, node2, node3, node4, node5, node6, node7, node8]

	node9, node10, node11, node12 = Node.new, Node.new(2), Node.new(3), Node.new(4)
	node13, node14, node15, node16 = Node.new(5), Node.new(6), Node.new(7), Node.new(8)
	node_array2 = [node9, node10, node11, node12, node13, node14, node15, node16]

	graph1 = UndirectedGraph.new(node_array1)
	graph1.add_edge_by_nodes(node1, node2, 2)
	graph1.add_edge_by_nodes(node1, node3, 3)
	graph1.add_edge_by_nodes(node3, node2, 2)
	graph1.add_edge_by_nodes(node2, node4, 1)
	graph1.add_edge_by_nodes(node2, node6, 2)
	graph1.add_edge_by_nodes(node4, node5, 2)
	graph1.add_edge_by_nodes(node6, node7, 2)
	graph1.add_edge_by_nodes(node7, node8, 1)

	graph2 = DirectedGraph.new(node_array2)
	graph2.add_edge_by_nodes(node9, node10, 2)
	graph2.add_edge_by_nodes(node9, node11, 3)
	graph2.add_edge_by_nodes(node11, node10, 2)
	graph2.add_edge_by_nodes(node10, node12, 1)
	graph2.add_edge_by_nodes(node10, node14, 2)
	graph2.add_edge_by_nodes(node12, node13, 2)
	graph2.add_edge_by_nodes(node14, node15, 2)
	graph2.add_edge_by_nodes(node15, node16, 1)

	# Shortest path in graph1 is [node3, node2, node6, node7, node8]
	# Shortest path in graph2 is [node11, node10, node14, node15, node16]

	text = 'returns an array of nodes whose order reflects the shortest path ' +
		'from the origin node to the destination node'
	it text do
		expect(dijkstra_shortest_path(node3, node8, graph1))
			.to eq([node3, node2, node6, node7, node8])
		expect(dijkstra_shortest_path(node11, node16, graph2))
			.to eq([node11, node10, node14, node15, node16])
	end

	text2 = 'returns an empty array when passed the same node as the origin and' +
		' destination'
	it text2 do
		expect(dijkstra_shortest_path(node5, node5, graph1)).to eq([])
		expect(dijkstra_shortest_path(node15, node15, graph2)).to eq([])
	end 
end
