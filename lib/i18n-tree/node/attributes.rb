module I18n
  module Tree
    module Node
      # is included first
      module AttributesBase
        attr_reader :attr

        # allow super in descendants
        def initialize(**attributes)
          @attr = {}
          attributes
        end

        def inspect_attributes; '' end

      end

      # must be included after all constructor extensions
      module AttributesValidOnly
        def initialize(**options)
          extra = super(**options)
          if (value = extra.delete(:value))
            log_warn "Discarding value #{value}."
          end
          if !extra.empty?
            raise ConstructionError.new("Cannot pass #{extra.inspect} to a #{self.class.name}", self)
          end
          @attr.freeze
          extra
        end
      end
    end
  end
end
