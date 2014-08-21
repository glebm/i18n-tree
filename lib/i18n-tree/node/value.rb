module I18n
  module Tree
    module Node
      module Value
        attr_reader :value

        def initialize(value: nil, **attributes)
          other_attr = super(**attributes)
          @attr[:value] = @value = value
          other_attr
        end

        def leaf?
          true
        end

        def value_for_h
          value
        end
      end
    end
  end
end
