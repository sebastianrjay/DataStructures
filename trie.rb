module Inserter
	def add_child(child_node)
		existing_child = @children[child_node.value]

		if !existing_child
			@children[child_node.value] = child_node
		elsif existing_child && !existing_child.terminates
			@children[child_node.value].terminates = child_node.terminates
		end

		@children[child_node.value]
	end
end

class TrieNode
	include Inserter
	attr_accessor :terminates
	attr_reader :value

	def initialize(value, terminates = false)
		@terminates = terminates
		@value = value
		@children = {}
	end

	def get_child_node_by_character(char)
		@children[char]
	end
end

class Trie
	include Inserter

	def initialize
		@children = {}
	end

	def add_word(string)
		current_node = @children[string[0]]

		string.chars.each_with_index do |char, i|
			if i == 0 && string.length == 1 && current_node
				current_node.terminates = true
			elsif i == 0 && current_node
				next
			elsif current_node && i == string.length - 1
				current_node = current_node.add_child(TrieNode.new(char, true))
			elsif !current_node && i == string.length - 1
				current_node = add_child(TrieNode.new(char, true))
			elsif current_node
				current_node = current_node.add_child(TrieNode.new(char))
			else
				current_node = add_child(TrieNode.new(char))
			end
		end

		self
	end

	def valid_prefix?(string)
		!!get_last_letter_node(string)
	end

	def valid_word?(string)
		last_letter_node = get_last_letter_node(string)
		!!last_letter_node && last_letter_node.terminates
	end

	private

		def get_last_letter_node(lookup_string)
			begin
				current_node = @children[lookup_string[0]]

				(lookup_string[1..-1] || "").chars.each do |char|
					current_node = current_node.get_child_node_by_character(char)
				end
			rescue => e
				return nil
			end

			current_node
		end
end
