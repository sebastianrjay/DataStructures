# About #
This is the repository where I implement some common data structures. I've put 
my graph implementations in their own repository, called "Graphs."

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
constructed, one can output a sorted array from it in `O(n)` time. But 
constructing a BinarySearchTree from an unsorted Array runs in `O(n * log(n))` 
time, like the most commonly-used comparison sort algorithm.

## Trie ##
This data structure allows one to check if a string is a valid prefix or a valid 
word in `O(n)` time, where `n` is the length of the string.
