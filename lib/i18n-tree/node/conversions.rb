module I18n
  module Tree
    module Node
      module Conversions
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          def from_h(hash)
            RootNode.new(children: nodes_from_h(hash))
          end

          def nodes_from_h(h)
            h.map do |k, v|
              if v.is_a?(Hash)
                IntermediateNode.new(key: k, children: nodes_from_h(v))
              else
                LeafNode.new(key: k, value: v)
              end
            end
          end
        end
      end
    end
  end
end
