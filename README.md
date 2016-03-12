# About #
This is the repository where I implement some common data structures. I've put 
my graph implementations in 
[their own repository, called "Graphs."](https://https://github.com/sebastianrjay/Graphs)

# Tests #
So far, the tests in the `spec` directory test only my `Trie` implementation.

Having [installed Ruby](https://github.com/rbenv/rbenv), run `rspec spec` to run 
the full test suite. It may be necessary to first install RSpec by running 
`gem install rspec`.

# Descriptions #

## Binary Search Tree ##
The classic tree implementation that allows `O(log(n))` insertion and `O(log(n))` 
lookup time. I'm not sure what the purpose of these is anymore, since hash 
tables enable `O(1)` lookup, insertion and deletion. Once the tree has been 
constructed, one can output a sorted array from it in `O(n)` time via in-order 
traversal. But constructing a BinarySearchTree from an unsorted array runs in 
`O(n * log(n))` time, like standard comparison sort algorithms.

My binary search tree implementation allows insertion of duplicate values; it 
stores one new node for each value inserted, regardless if the value has already 
been stored to another node in the tree. It also deletes only one node when 
removing a value existing in multiple nodes. Simpler (and perhaps more elegant) 
implementations prohibit insertion of duplicate values.

## Doubly Linked List ##
Not much to say here. The Ruby version is instantiated from an array of nodes, 
while the JavaScript version's constructor takes a head and tail node as 
arguments, forcing the programmer to later add other nodes via the appendNode 
or insertNode methods.

## Least Recently Used Cache (LRU Cache) ##
Whee, ES6. The cache has a limited size, as specified in the constructor. The 
fetchCallbackForMissingData argument to the LRUCache#get method is a callback 
that returns data from someplace external to the cache, and is invoked if the 
cache does not contain the data sought when invoking LRUCache#get.

## Trie ##
This data structure allows one to check if a string is a valid prefix or a valid 
word in `O(n)` time, where `n` is the length of the string.

Basically, it's a nested hash table of letter nodes with a boolean `@terminates` 
flag on each node, indicating whether or not the given node terminates a word 
saved to the trie.
