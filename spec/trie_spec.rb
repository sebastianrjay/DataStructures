require_relative 'spec_helper'
require_relative '../trie'

describe Trie do
	before(:all) do
		@trie = Trie.new
		@words = ['aardvark', 'applesauce', 'apple', 'breathe', 'breath', 'breathed']
		@words.each do |word|
			@trie.add_word(word)
		end
	end

	describe '#valid_word?(string)' do
		it 'returns true for valid words' do
			@words.each do |word|
				expect(@trie.valid_word?(word)).to eq(true)
			end
		end

		it 'returns false for invalid words' do
			expect(@trie.valid_word?('invalid')).to eq(false)
			expect(@trie.valid_word?('aard')).to eq(false)
			expect(@trie.valid_word?('appl')).to eq(false)
			expect(@trie.valid_word?('applesau')).to eq(false)
			expect(@trie.valid_word?('applesauces')).to eq(false)
		end
	end

	describe '#valid_prefix?(string)' do
		it 'returns true for valid prefixes' do
			expect(@trie.valid_prefix?('aard')).to eq(true)
			expect(@trie.valid_prefix?('apple')).to eq(true)
			expect(@trie.valid_prefix?('breath')).to eq(true)
			expect(@trie.valid_prefix?('breathed')).to eq(true)
		end

		it 'returns false for invalid prefixes' do
			expect(@trie.valid_prefix?('breather')).to eq(false)
			expect(@trie.valid_word?('applesauces')).to eq(false)
		end
	end
end

describe TrieNode do
	before(:all) do
		@trie = Trie.new
		@words = ['aardvark', 'applesauce', 'apple', 'breathe', 'breath', 'breathed']
		@words.each do |word|
			@trie.add_word(word)
		end
		@node = @trie.get_child_node_by_character('a')
	end

	describe '#valid_suffix(string)?' do
		it 'should return true for a valid suffix' do
			expect(@node.valid_suffix?('pple')).to eq(true)
			expect(@node.valid_suffix?('pplesauce')).to eq(true)
			expect(@node.valid_suffix?('ardvark')).to eq(true)
		end

		it 'should return false for a string that does not complete a word' do
			expect(@node.valid_suffix?('ppl')).to eq(false)
			expect(@node.valid_suffix?('pplesauc')).to eq(false)
		end
	end

	describe '#valid_word_contents?(string)' do
		it 'should return true for valid word contents' do
			expect(@node.valid_word_contents?('ppl')).to eq(true)
			expect(@node.valid_word_contents?('pplesauc')).to eq(true)
		end

		it 'should return false for invalid word contents' do
			expect(@node.valid_word_contents?('pqr')).to eq(false)
			expect(@node.valid_word_contents?('pplesu')).to eq(false)
		end
	end
end
