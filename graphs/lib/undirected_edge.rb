class UndirectedEdge
  attr_reader :nodes
  attr_accessor :value

  def initialize(node1, node2, value = 1)
    raise "Cannot create UndirectedEdge within a Node" if node1 == node2
    @nodes = [node1, node2].freeze
    @value = value
  end

  def include?(node)
    @nodes.include?(node)
  end

  def other_node(node)
    if @nodes[0] == node
      return @nodes[1]
    elsif @nodes[1] == node
      return @nodes[0]
    else
      raise "UndirectedEdge does not contain node passed to self#other_node"
    end
  end
end
