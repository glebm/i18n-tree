module I18n
  module Tree
    class BaseError < RuntimeError
      include Term::ANSIColor
    end

    class NodeNotFoundError < BaseError
      def initialize(node, query)
        super "#{intense_red "Node not found"} at #{cyan query.inspect} in #{node.inspect}"
      end
    end

    class ConstructionError < BaseError
      def initialize(message, tree)
        super "#{intense_red 'Error building tree'}: #{message}\n#{tree.inspect}"
      end
    end
  end
end
