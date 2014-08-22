require_relative './i18n-tree/node'
module I18n
  module Tree
    # distinguish optional arguments that may be nil
    Undefined = Object.new

    class << self
      # convenience method

      # @return [I18n::Tree::RootNode] tree from hash
      def [](hash)
        Node.from_h(hash)
      end

      # @return [I18n::Tree::IntermediateNode|I18n::Tree::LeafNode] node from key or key + value
      def node(key, value = Undefined, **attr)
        if value == Undefined
          IntermediateNode.new(key: key, **attr)
        else
          LeafNode.new(key: key, value: value, **attr)
        end
      end
    end
  end
end
