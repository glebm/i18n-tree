# coding: utf-8
require_relative './color'

module I18n
  module Tree
    module Logger
      def log_verbose(message)
        log_style :verbose, message if ENV['VERBOSE']
      end

      def log_warn(message)
        log_style :warn, "[WARN] #{message}"
      end

      def log_error(message)
        log_style :error, message
      end

      def log_style(style, message)
        log_stderr Color::ANSI.colorize(style_colors(style), "i18n-tree: #{message}")
      end

      def style_colors(type)
        COLORS[type]
      end

      COLORS = {
          verbose: :green,
          warn: :yellow,
          error: [:red, :bold]
      }

      def log_stderr(*args)
        STDERR.puts(*args)
      end
    end
  end
end
