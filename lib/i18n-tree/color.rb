require 'term/ansicolor'

Term::ANSIColor.coloring = STDERR.isatty

module I18n
  module Tree
    module Color
      module ANSI
        extend self

        def colorize(colors, str)
          Array(colors).reverse_each.inject(str) do |s, color|
            Term::ANSIColor.send(color, s)
          end
        end

        def colorize_cycle(s, i)
          Term::ANSIColor.color 1 + i % 15, s
        end
      end
    end
  end
end
