require_relative './i18n-tree/node'
module I18n
  module Tree
    class << self
      def [](hash)
        Node.from_h(hash)
      end
    end
  end
end
