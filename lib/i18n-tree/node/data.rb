module I18n
  module Tree
    module Node
      # arbitrary data a la jQuery.fn.data
      module Data
        attr_reader :data

        def initialize(data: Hamster::EmptyHash, **attributes)
          other_attr = super(**attributes)
          @attr[:data] = @data = case data
                                   when Hamster::Hash
                                     data
                                   else
                                     Hamster::Hash[data]
                                 end
          other_attr
        end

        def inspect_attributes
          if data.empty?
            super
          else
            super << " #{Color::ANSI.colorize :bright_black, data.inspect}"
          end
        end
      end
    end
  end
end
