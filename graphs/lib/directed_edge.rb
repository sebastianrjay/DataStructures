class DirectedEdge
  attr_reader :origin, :destination
  attr_accessor :value

  def initialize(origin_node, destination_node, value = 1)
    if origin_node == destination_node
      raise "Cannot create DirectedEdge within a Node"
    end
    
    @origin, @destination = origin_node, destination_node
    @value = value
  end

  def include?(node)
    @origin == node || @destination == node
  end
end
