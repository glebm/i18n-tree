module I18n
  module Tree
    module Node
      module Key
        attr_reader :key

        def initialize(key:, **attributes)
          other_attr  = super(**attributes)
          @attr[:key] = @key = key.to_s
          other_attr
        end

        def root?
          false
        end

        def to_h
          {key => value_for_h}
        end
      end
    end
  end
end
