module I18n
  module Tree
    module Node
      module Children
        attr_reader :children

        # i18n leaf is a node with value
        # a non-leaf node has no children, corresponding to i18n {}
        def leaf?
          false
        end

        def initialize(children: Hamster::EmptyHash, **attributes)
          extra_attr = super(**attributes)
          @attr[:children] = @children = case children
                                           when Hash
                                             Hamster::Hash[children]
                                           when Hamster::Hash
                                             children
                                           else
                                             Hamster::Hash.new children.map { |c| [c.key, c] }
                                         end
          extra_attr
        end

        def each_child(&block)
          return to_enum(:each_child) { @children.length } unless block
          @children.each { |_key, child| block.yield child }
          self
        end

        def children_alpha
          @children_alpha ||= begin
            sorted = @children.values.to_a
            sorted.sort_by!(&:key)
            sorted
          end
        end

        def value_for_h
          children_alpha.inject({}) { |h, child| h.merge! child.to_h }
        end

        def inspect_children(level: 0)
          level_next = level + 1
          level_ident = ('  ' * level).freeze
          children_alpha.map { |c| "\n#{level_ident}#{c.inspect(level: level_next)}" }.join
        end
      end
    end
  end
end
