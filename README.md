# About #
Common data structures written in Ruby. Some include tests. The `graphs` folder 
includes an implementation of Dijkstra's algorithm.

# Descriptions #

## Binary Heap ##
See the binary heap [README](binary_heaps/README.md)

## Binary Search Tree ##
* `O(log(n))` insertion, lookup and deletion time
* Breadth-first traversal
* In-order, pre-order and post-order traversal methods take optional 
`max_visited_nodes` and `current_node` parameters, to start traversal from a 
certain node and traverse a limited number of nodes
* Outputs a sorted array in `O(n)` time via in-order traversal
* Can store duplicate values

## Doubly Linked List ##
Standard Doubly Linked List implementation performing all operations in `O(1)` 
time, excluding `#to_a` and `#values` array conversion methods. Features `O(1)` 
`#has_value?(value)` and `#node_count` operations, thanks to an internal hash 
table.

## Graphs ##
See the graps [README](graphs/README.md)

## Least Recently Used Cache (LRU Cache) ##
Stores data under a lookup key, and allows the end user to specify a max cache 
size in bytes on instantiation. Performs all operations including `get(key)` and 
`set(key, data)` in `O(1)` time.

The purpose is to cache data, but to limit memory usage and store only the most 
recently accessed data. 

## Trie ##
This data structure allows one to check if a string is a valid prefix or a valid 
word in `O(n)` time, where `n` is the length of the string.

Basically, it's a nested hash table of letter nodes with a boolean `@terminates` 
flag on each node, indicating whether or not the given node terminates a word 
saved to the trie.

# Note #
My [graph](https://github.com/sebastianrjay/Graphs) and 
[binary heap](https://github.com/sebastianrjay/BinaryHeap) implementations are 
also hosted in their own repositories.
