require "jekyll"

module Jekyll
  module Amp
    module Video
      extend self
      def render(doc, site)
        doc.css('video:not([width])').each do |video|
          video['width']  = 4
          video['height'] = 3
        end
        doc.css('video').each do |video|
          video.name = "amp-video"
          video['layout'] = "responsive"
        end
      end
    end
  end
end
