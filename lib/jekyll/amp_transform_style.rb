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
          contents = doc.css("style[#{type}]").map do |style|
            style.remove
            style.content
          end

          style = Nokogiri::XML::Node.new "style", doc
          style[type] = type
          style.content = contents.join("");
          head[0].add_child(style);
        end
      end
    end
  end
end
