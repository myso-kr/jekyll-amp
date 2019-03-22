require "jekyll"
require 'nokogumbo'
require_relative "./amp_imports"
require_relative "./amp_transform_audio"
require_relative "./amp_transform_video"
require_relative "./amp_transform_image"
require_relative "./amp_transform_style"

module Jekyll
  class AmpBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @tag = markup
      super
    end

    def render(context)
      contents = super
      content = Liquid::Template.parse(contents).render context

      site = context.registers[:site]
      doc = Nokogiri::HTML5(content.strip)
      Jekyll::Amp::Audio.render(doc, site)
      Jekyll::Amp::Video.render(doc, site)
      Jekyll::Amp::Image.render(doc, site)
      # Jekyll::Amp::Style.render(doc, site)
      Jekyll::Amp.imports(doc)

      html = doc.serialize
      html.gsub!(/\=\"\"/, "")
      # html.gsub!(/<noscript><\/noscript>/, "")
    end
  end
end

Liquid::Template.register_tag("amp", Jekyll::AmpBlock)
