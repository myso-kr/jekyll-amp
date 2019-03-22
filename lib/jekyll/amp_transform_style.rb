require "jekyll"

module Jekyll
  module Amp
    module Style
      extend self
      def render(doc, site)
        merge_style(doc, 'amp-boilerplate')
        merge_style(doc, 'amp-custom')
      end

      private
      def merge_style(doc, type)
        head = doc.css('head')
        if head.length > 0
          wraps = doc.css("head style[#{type}]")
          if wraps.length == 1
            contents = doc.css("body style[#{type}]").map do |style|
              style.remove
              style.content
            end
            wraps[0].content = contents.join("");
          end
        end
      end
    end
  end
end
