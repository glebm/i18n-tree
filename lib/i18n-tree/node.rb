require 'hamster/hash'
require 'hamster/list'

require_relative './logger'
require_relative './node/errors'
require_relative './node/conversions'
require_relative './node/children'
require_relative './node/key'
require_relative './node/value'
require_relative './node/data'
require_relative './node/attributes'
require_relative './node/traversal'
require_relative './node/derivation'

module I18n

  # RootNode (Children [IntermediateNode (Children, Key) | LeafNode (Key, Value)])
  module Tree
    # every node type includes this module
    module Node
      include AttributesBase
      include Data
      include Traversal
      include Derivation
      include Conversions
      include Logger

      def eql?(other)
        other.is_a?(Node) && other.attr == attr && other.children == children
      end
      alias_method :==, :eql?
    end

    # virtual root node
    class RootNode
      include Node
      include Children
      include AttributesValidOnly

      def root?
        true
      end

      alias_method :to_h, :value_for_h

      def inspect(level: 0)
        "#{Color::ANSI.colorize [:bold, :green], '[tree]:'}#{inspect_children(level: level + 1)}#{inspect_attributes}"
      end
    end

    Empty = RootNode.new

    class IntermediateNode
      include Node
      include Key
      include Children
      include AttributesValidOnly

      def inspect(level: 0)
        "#{Color::ANSI.colorize_cycle self.key, level}#{inspect_children(level: level)}"
      end
    end

    class LeafNode
      include Node
      include Key
      include Value
      include AttributesValidOnly

      def children
        Hamster::EmptyHash
      end

      def append(node)
        log_warn "Adding child #{node.inspect} to a leaf #{inspect}."
        super node
      end

      def derive(klass: self.class, **attr)
        attr[:klass] = IntermediateNode if !attr[:children].empty?
        super **attr
      end

      def inspect(level: 0)
        "#{Color::ANSI.colorize_cycle key + ':', level} #{Color::ANSI.colorize :italic, value.inspect}"
      end
    end
  end
end
