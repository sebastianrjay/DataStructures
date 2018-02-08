module AdjacencyListGraph
  class Base
    attr_reader :nodes

    def initialize(nodes = [])
      if nodes.is_a?(Set)
        @nodes = nodes
      elsif nodes.is_a?(Array)
        @nodes = nodes.inject(Set.new) { |set, node| set << node }
      else
        msg = "The node list passed to #{self.class}#initialize must be of " +
          "class Array or Set"
        raise msg
      end

      @edges = {}
    end

    def add_node(node)
      unless @nodes.include?(node)
        @nodes << node
        node
      end
    end

    def edges
      # Since @edges is a hash whose keys are concatenated object_id strings and 
      # whose values are the actual edge instances, we return @edges.values
      @edges.values
    end

    def find_edge_by_nodes(node1, node2)
      self.class == UndirectedGraph && @edges[generate_edge_key(node2, node1)] ||
        @edges[generate_edge_key(node1, node2)]
    end

    def get_edge_value_by_nodes(node1, node2)
      begin
        return find_edge_by_nodes(node1, node2).value
      rescue => e
        raise missing_edge_error_message(__callee__)
      end
    end

    # Unneeded method; end user (programmer) can also use #nodes.include?(node)
    def has_node?(node)
      nodes.include?(node)
    end

    def set_edge_value_by_nodes(origin_node, destination_node, val)
      begin
        edge = find_edge_by_nodes(origin_node, destination_node)
        edge.value = val
        return edge
      rescue => e
        raise missing_edge_error_message(__callee__)
      end
    end

    # The last five public methods are unneeded but included for completeness.

    def neighbors(node)
      node.neighbors
    end

    def get_edge_value(edge)
      edge.value
    end

    def set_edge_value(edge, val)
      edge.value = val
    end

    def get_node_value(node)
      node.value
    end

    def set_node_value(node, val)
      node.value = val
    end

    protected

      def generate_edge_key(origin_node, destination_node)
        # I could have made this a class method, but then calling it would be 
        # more verbose. It returns an integer lookup key of class Bignum, to 
        # enable O(1) creation, lookup and deletion of edges.
        (origin_node.object_id.to_s + destination_node.object_id.to_s).to_i
      end

    private

      def missing_edge_error_message(method_name)
        "No #{self.class.to_s[0..-6]}Edge exists between the origin and " +
          "destination nodes passed to #{self.class}##{method_name}"
      end
  end
end
