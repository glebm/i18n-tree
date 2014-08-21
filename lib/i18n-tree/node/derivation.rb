module I18n
  module Tree
    module Node
      module Derivation
        def append(node)
          derive(children: node.children.put(node.key, node))
        end

        def derive(klass: self.class, **attr)
          klass.new derive_attributes(attr)
        end

        def merge(other)
          derive(children: other.children.inject(self.children) { |c, key, value|
            value_was = c[key]
            if value_was
              c.put(key, value_was.merge(value))
            else
              c.put(key, value)
            end
          })
        end

        def derive_attributes(attr)
          self.attr.merge(attr)
        end
      end
    end
  end
end
