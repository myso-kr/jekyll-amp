require "jekyll"
require 'nokogumbo'

module Jekyll
  module Amp
    extend self
    def imports(doc)
      import_modules(doc)
      import_main(doc)
    end

    private

    # https://github.com/ampproject/amphtml/tree/master/extensions
    # last updates: 2019-03-21T21:25:37.854Z
    def plugins()
      exports = [];
      exports << "amp-3d-gltf"
      exports << "amp-3q-player"
      exports << "amp-a4a"
      exports << "amp-access-laterpay"
      exports << "amp-access-poool"
      exports << "amp-access-scroll"
      exports << "amp-access"
      exports << "amp-accordion"
      exports << "amp-action-macro"
      exports << "amp-ad-custom"
      exports << "amp-ad-exit"
      exports << "amp-ad-network-adsense-impl"
      exports << "amp-ad-network-adzerk-impl"
      exports << "amp-ad-network-cloudflare-impl"
      exports << "amp-ad-network-doubleclick-impl"
      exports << "amp-ad-network-fake-impl"
      exports << "amp-ad-network-gmossp-impl"
      exports << "amp-ad-network-triplelift-impl"
      exports << "amp-ad"
      exports << "amp-addthis"
      exports << "amp-analytics"
      exports << "amp-anim"
      exports << "amp-animation"
      exports << "amp-apester-media"
      exports << "amp-app-banner"
      exports << "amp-audio"
      exports << "amp-auto-ads"
      exports << "amp-auto-lightbox"
      exports << "amp-autocomplete"
      exports << "amp-base-carousel"
      exports << "amp-beopinion"
      exports << "amp-bind"
      exports << "amp-bodymovin-animation"
      exports << "amp-brid-player"
      exports << "amp-brightcove"
      exports << "amp-byside-content"
      exports << "amp-call-tracking"
      exports << "amp-carousel"
      exports << "amp-consent"
      exports << "amp-crypto-polyfill"
      exports << "amp-dailymotion"
      exports << "amp-date-countdown"
      exports << "amp-date-display"
      exports << "amp-date-picker"
      exports << "amp-delight-player"
      exports << "amp-dynamic-css-classes"
      exports << "amp-embedly-card"
      exports << "amp-experiment"
      exports << "amp-facebook-comments"
      exports << "amp-facebook-like"
      exports << "amp-facebook-page"
      exports << "amp-facebook"
      exports << "amp-fit-text"
      exports << "amp-font"
      exports << "amp-form"
      exports << "amp-fx-collection"
      exports << "amp-fx-flying-carpet"
      exports << "amp-geo"
      exports << "amp-gfycat"
      exports << "amp-gist"
      exports << "amp-google-document-embed"
      exports << "amp-google-vrview-image"
      exports << "amp-gwd-animation"
      exports << "amp-hulu"
      exports << "amp-iframe"
      exports << "amp-ima-video"
      exports << "amp-image-lightbox"
      exports << "amp-image-slider"
      exports << "amp-image-viewer"
      exports << "amp-imgur"
      exports << "amp-inputmask"
      exports << "amp-instagram"
      exports << "amp-install-serviceworker"
      exports << "amp-izlesene"
      exports << "amp-jwplayer"
      exports << "amp-kaltura-player"
      exports << "amp-lightbox-gallery"
      exports << "amp-lightbox"
      exports << "amp-list"
      exports << "amp-live-list"
      exports << "amp-mathml"
      exports << "amp-mowplayer"
      exports << "amp-mraid"
      exports << "amp-mustache"
      exports << "amp-next-page"
      exports << "amp-nexxtv-player"
      exports << "amp-o2-player"
      exports << "amp-ooyala-player"
      exports << "amp-orientation-observer"
      exports << "amp-pan-zoom"
      exports << "amp-payment-google-button"
      exports << "amp-payment-google-inline-async"
      exports << "amp-payment-google-inline"
      exports << "amp-pinterest"
      exports << "amp-playbuzz"
      exports << "amp-position-observer"
      exports << "amp-powr-player"
      exports << "amp-reach-player"
      exports << "amp-recaptcha-input"
      exports << "amp-reddit"
      exports << "amp-riddle-quiz"
      exports << "amp-script"
      exports << "amp-selector"
      exports << "amp-share-tracking"
      exports << "amp-sidebar"
      exports << "amp-skimlinks"
      exports << "amp-slides"
      exports << "amp-smartlinks"
      exports << "amp-social-share"
      exports << "amp-soundcloud"
      exports << "amp-springboard-player"
      exports << "amp-sticky-ad"
      exports << "amp-story-auto-ads"
      exports << "amp-story"
      exports << "amp-subscriptions-google"
      exports << "amp-subscriptions"
      exports << "amp-timeago"
      exports << "amp-twitter"
      exports << "amp-user-notification"
      exports << "amp-video-docking"
      exports << "amp-video-iframe"
      exports << "amp-video"
      exports << "amp-viewer-assistance"
      exports << "amp-viewer-integration"
      exports << "amp-vimeo"
      exports << "amp-vine"
      exports << "amp-viqeo-player"
      exports << "amp-viz-vega"
      exports << "amp-vk"
      exports << "amp-web-push"
      exports << "amp-wistia-player"
      exports << "amp-yotpo"
      exports << "amp-youtube"
    end

    def create_script(doc, src)
      script = Nokogiri::XML::Node.new "script", doc
      script['src'] = src
      script['async'] = ""
      return script
    end

    def create_module(doc, amp_plugin, type)
      script = create_script(doc, "https://cdn.ampproject.org/v0/#{amp_plugin}-latest.js")
      script[type] = amp_plugin
      return script
    end

    def import_modules(doc)
      plugins.map do |amp_plugin|
        import_module(doc, amp_plugin, 'custom-element')
        import_module(doc, amp_plugin, 'custom-template')
      end
    end

    def import_module(doc, amp_plugin, type)
      head = doc.css('head')
      if head.length > 0
        has_elements = doc.css(type == 'custom-element' ? "#{amp_plugin}" : "template[type='#{amp_plugin}']")
        tag_elements = doc.css("script[#{type}='#{amp_plugin}']")
        if has_elements.length > 0
          if tag_elements.length == 0
            head[0].add_child(create_module(doc, amp_plugin, type));
          else
            head[0].add_child(tag_elements[0])
          end
        else
          tag_elements.remove
        end
      end
    end

    # https://cdn.ampproject.org/v0.js
    def import_main(doc)
      href = "https://cdn.ampproject.org/v0.js"
      head = doc.css('head')
      if head.length > 0
        tag_elements = doc.css("script[src='#{href}']")
        if tag_elements.length == 0
          head[0].add_child(create_script(doc, href));
        else
          head[0].add_child(tag_elements[0]);
        end
      end
    end
  end
end
