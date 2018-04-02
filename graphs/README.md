# Description

This repository features implementations of an undirected adjacency list
graph, a directed adjacency list graph, and an accompanying implementation of 
Dijkstra's algorithm that works for both graphs.

# Tests

The RSpec tests in the spec folder exhaustively test my edge, node and graph 
implementations. I have also added tests for my implementations of 
Dijkstra's algorithm and Kahn's topological sort algorithm.

To run all RSpec tests, run `rspec spec` from the `Graphs` root directory. 
Assuming Ruby is [installed](https://github.com/rbenv/rbenv), it may be 
necessary to first install RSpec via `gem install rspec`.

# A Basic Ruby Graph Implementation, and Its Avoidable O(n) Processes

```ruby
	require 'set'
	
	class BasicUndirectedGraph
		attr_reader :edges, :nodes
		def initialize
			@edges, @nodes = Set.new, Set.new
		end

		def add_edge(edge)
			# O(1)
			unless connected_nodes?(edge.nodes[0], edge.nodes[1])
				add_node(edge.nodes[0])
				add_node(edge.nodes[1])
				edge.nodes[0].add_neighbor(edge.nodes[1])
				edge.nodes[1].add_neighbor(edge.nodes[0])
				@edges << edge
			end
		end

		def add_edge_by_nodes(node1, node2, value)
			# O(1), since connected_nodes?(node1, node2) and add_edge(edge) are O(1)
			unless connected_nodes?(node1, node2)
				add_edge(UndirectedEdge.new(node1, node2, value))
			end
		end

		def add_node(node)
			# O(1)
			@nodes << node unless @nodes.include?(node)
		end

		def connected_nodes?(node1, node2)
			# O(1), assuming Node#neighbors is a Set
			node1.neighbors.include?(node2) && node2.neighbors.include?(node1)
		end

		def delete_edge(edge)
			# O(1)
			edge.nodes[0].delete_neighbor(edge.nodes[1])
			edge.nodes[1].delete_neighbor(edge.nodes[0])
			@edges.delete(edge)
		end

		def delete_edge_by_nodes(node1, node2)
			# We have to iterate through @edges and find the edge linking node1 and
			# node2. Thus, this method runs in O(n = edges.count) time.
			@edges.delete_if do |edge| 
				edge.nodes.include?(node1) && edge.nodes.include?(node2)
			end
		end

		def delete_node(node)
			# O(n) runtime again, assuming Node#neighbors is a Set,
			# where n is [node.neighbors.count, @edges.count].max
			@edges.delete_if {|edge| edge.nodes.include?(node) }
			node.neighbors.each {|neighbor| neighbor.delete_neighbor(node) }
			@nodes.delete(node)
		end

		def get_edge_value(node1, node2)
			# Same O(n = edges.count) runtime as delete_edge_by_nodes(node1, node2)
			@edges.find do |edge| 
				edge.nodes.include?(node1) && edge.nodes.include?(node2)
			end.value
		end

		def set_edge_value(node1, node2, value)
			# Same O(n = edges.count) runtime as delete_edge_by_nodes(node1, node2)
			@edges.find do |edge| 
				edge.nodes.include?(node1) && edge.nodes.include?(node2)
			end.value = value
		end
	end
```

The above graph implementation is not bad. It uses the Ruby `Set` data structure 
to avoid `O(n)` array lookups in many places. However, it can only retrieve an 
edge by its nodes in `O(edges.count)` time.

# How Can We Do Better?  

My graph implementations in the `lib` folder take advantage of Ruby's `Hash` 
data structure and `object_id` property to retrieve edges by their nodes in 
`O(1)` time, via `#generate_edge_key(node1, node2)`. Thus, their 
`delete_edge_by_nodes(node1, node2)`, `get_edge_value(node1, node2)` and 
`set_edge_value(node1, node2, value)` methods run in `O(1)` time.

To reflect the directionality of its edges, the `DirectedGraph` class adds a 
neighbor node `node2` to node `node1` if and only if `node1` is the origin node 
and `node2` is the destination node for a `DirectedEdge` instance connecting the 
two nodes. This is useful in applications such as Dijkstra's algorithm, where we 
want to access a `Node`'s neighbors without searching through all edges in the 
graph, and without performing work on neighbor `Node`'s to which no path exists 
from the `Node` calling `Node#neighbors`.

The `UndirectedGraph` class adds a neighbor node `node2` to node `node1` for any 
`UndirectedEdge` connecting the two nodes. Since edges are non-directional, each 
`Node` in an `UndirectedEdge` instance has `UndirectedEdge#other_node(node)` as 
a neighbor.

The graphs complete all operations in `O(1)` or `O(1)` amortized time by relying 
on hash maps, the Ruby `Set` data structure, and Ruby's `object_id` property. 
The only exceptions are:
* `UndirectedGraph#neighbors(node)` and `DirectedGraph#neighbors(node)`, which 
returns a duplicate `Set` of the node's neighbors. Thus, it runs in `O(n)` time, 
where `n` is the number of the node's neighbors.
* `UndirectedGraph#delete_node(node)`, because it must delete all 
edges associated with the node. Thus, it runs in `O(n)` time, where `n` is the 
number of edges connected to the node.
* `DirectedGraph#delete_node(node)`, which runs in `O(m)` time, where `m` is the 
number of edges in the DirectedGraph instance. We must search through all edges 
in the graph because we can only look up edges with two `Node`

# To Do

* Further improve abstraction of RSpec tests
* Consider making `Node#neighbors` non-directional in the `DirectedGraph`. 
There is a tradeoff here between maximizing performance of 
`DirectedGraph#delete_node(node)` and Dijkstra's algorithm for the 
`DirectedGraph`, as described above.
