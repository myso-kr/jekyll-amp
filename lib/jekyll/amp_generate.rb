require "jekyll"
require "rodash"

module Jekyll
  class AMPPage < Page
    def initialize(site, base, dir, doc)
      id = doc.basename_without_ext;
      id.sub!(/^[\d]{4}-[\d]{2}-[\d]{2}-/, "")

      @site = site
      @base = base
      @dir  = dir
      @url  = dir
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(@base, "_posts"), doc.basename)
      self.content               = site.find_converter_instance(Jekyll::Converters::Markdown).convert(doc.content)
      self.data['body']          = (Liquid::Template.parse self.content).render site.site_payload
      self.data = doc.data.merge(self.data)
      self.data.delete('excerpt')
      self.data.delete('permalink')

      self.data['canonical_url'] = doc.url
    end
  end
  class AMPGenerator < Generator
    safe :true
    priority :low
    def generate_story(site)
      story_using = Rodash.get(site.config, 'amp.story')
      story_collection = Rodash.get(site.config, 'amp.story.collection', "stories")
      story_layouts = Rodash.get(site.config, 'amp.story.layout', "amp-story")
      if story_using != nil
        stories = site.collections[story_collection] = Collection.new(site, story_collection)
        site.posts.docs.map do |doc|
          stories.docs << Document.new(doc.path, :site => site, :collection => stories).tap do |new_post|
            new_post.read
            new_post.data["layout"] = story_layouts
            new_post.data["permalink"] = "/#{story_collection}#{doc.url}"
          end
        end
      end
    end
    def generate(site)
      generate_story(site)
      site.collections.each do |_, collection|
        collection.docs.map do |doc|
          dir = doc.collection.label.gsub(/^posts$/, "")
          id = doc.basename_without_ext.to_s.sub(/^[\d]{4}-[\d]{2}-[\d]{2}-/, "");
          site.pages << AMPPage.new(doc.site, doc.site.source, File.join('/', dir, id), doc).tap do |new_page|
            new_page.data = doc.data.merge(new_page.data)
            new_page.data["layout"] = doc.data["layout"]
            new_page.data["permalink"] = doc.url
          end
        end
      end
    end
  end
end
