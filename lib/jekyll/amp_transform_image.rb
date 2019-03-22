require "jekyll"
require 'fastimage'
require 'uri'

module Jekyll
  module Amp
    module Image
      extend self
      def render(doc, site)
        doc.css('img:not([width])').each do |image|
          if image['src'].start_with?('http://', 'https://')
            src = image['src']
          else
            src = File.join(Dir.pwd, site.config.destination, image['src'])
          end
          begin
            size = FastImage.size(src, :raise_on_failure=>true, :timeout=>2.0)
            image['width']  = size[0]
            image['height'] = size[1]
          rescue Exception => e
            image['width']  = 4
            image['height'] = 3
          end
        end
        doc.css('img').each do |image|
          image.name = "amp-img"
          image['layout'] = "responsive"
        end
        doc.css('picture').each do |picture|
          amp_img = picture.css('amp-img')
          picture.add_next_sibling(amp_img) unless amp_img.empty?
          picture.remove
        end
        doc.css('amp-img').each do |amp_img|
          if amp_img.parent.name != "amp-story-grid-layer"
            noscript = Nokogiri::XML::Node.new "noscript", doc
            noscript_img = amp_img.dup
            noscript_img.remove_attribute('layout')
            noscript_img.name = 'img'
            noscript.add_child(noscript_img)
            amp_img.add_child(noscript)
          end
        end
      end
    end
  end
end
