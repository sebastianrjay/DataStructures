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
