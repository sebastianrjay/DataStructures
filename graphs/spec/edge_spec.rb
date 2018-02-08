require_relative 'spec_helper'

def test_edge_class(edge_class)
  describe edge_class do
    before(:all) do
      instantiate_nodes
      @edge1 = edge_class.new(@node1, @node2)
    end

    describe '#initialize' do
      it 'sets a default value if none is given' do   
        expect(@edge1.value).to eq(1)
      end

      it 'takes an optional value if given' do
        edge = edge_class.new(@node1, @node2, 5)
        expect(edge.value).to eq(5)
      end

      it 'raises an error if passed the same node in both arguments' do
        expect { edge_class.new(@node2, @node2) }
          .to raise_error("Cannot create #{edge_class} within a Node")
      end
    end

    describe '#include?(node)' do
      it 'returns true for either member node' do
        expect(@edge1.include?(@node1)).to eq(true)
        expect(@edge1.include?(@node2)).to eq(true)
      end

      it 'returns false for a non-member node' do
        expect(@edge1.include?(@node3)).to eq(false)
      end
    end
  end
end

test_edge_class(DirectedEdge)
test_edge_class(UndirectedEdge)

describe DirectedEdge do
  before(:all) do
    instantiate_nodes
    @edge1 = DirectedEdge.new(@node1, @node2)
  end

  describe '#origin' do
    it 'should return the origin node' do
      expect(@edge1.origin).to eq(@node1)
    end
  end

  describe '#destination' do
    it 'should return the destination node' do
      expect(@edge1.destination).to eq(@node2)
    end
  end
end

describe UndirectedEdge do
  before(:all) do
    instantiate_nodes
    @edge1 = UndirectedEdge.new(@node1, @node2)
  end

  describe '#nodes' do
    it 'should return an unmodifiable array of exactly two nodes' do
      expect(@edge1.nodes.map(&:class)).to eq([Node, Node])
      expect { @edge1.nodes[0] = @node5 }.to raise_error(RuntimeError)
    end
  end

  describe '#other_node(node)' do
    it 'returns the other member node' do
      expect(@edge1.other_node(@node1)).to eq(@node2)
      expect(@edge1.other_node(@node2)).to eq(@node1)
      expect(@edge1.include?(@node1)).to eq(true)
      expect(@edge1.include?(@node2)).to eq(true)
    end

    it 'raises an error if the given node is not a member node' do
      msg = "UndirectedEdge does not contain node passed to self#other_node"
      expect { @edge1.other_node(@node3) }
        .to raise_error(msg)
    end
  end
end
