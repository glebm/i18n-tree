module I18n
  module Tree
    module Node
      module Derivation
        def append(node)
          derive(children: children.put(node.key, node))
        end

        def append_at(path, node)
          return append(node) if !path || path.empty?
          key, rest = path.split('.', 2)
          derive(children: children.put(key, children[key].append_at(rest, node)))
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
