require "jekyll"

module Jekyll
  module Amp
    module Audio
      extend self
      def render(doc, site)
        doc.css('audio').each do |audio|
          audio.name = "amp-audio"
          audio['layout'] = "responsive"
        end
      end
    end
  end
end
