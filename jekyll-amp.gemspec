# coding: utf-8
# frozen_string_literal: true
Gem::Specification.new do |spec|
  spec.name          = 'jekyll-amp'
  spec.version       = '1.0.0'
  spec.authors       = ['Choi Won']
  spec.email         = ['help@myso.kr']
  spec.summary       = 'A Jekyll plugin to generate Accelerated Mobile Pages.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/myso-kr/jekyll-amp'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0.0'
  spec.files         = [
    'lib/jekyll-amp.rb',
    'lib/jekyll/amp.rb',
    'lib/jekyll/amp_generate.rb',
    'lib/jekyll/amp_imports.rb',
    'lib/jekyll/amp_transform_image.rb',
    'lib/jekyll/amp_transform_audio.rb',
    'lib/jekyll/amp_transform_video.rb',
    'lib/jekyll/amp_transform_style.rb'
  ]
  spec.require_paths = ['lib']

  spec.add_dependency "jekyll", "~> 3.0"
  spec.add_runtime_dependency 'rodash', ['>= 3.0.0']
  spec.add_runtime_dependency 'nokogumbo', ['>= 2.0.1']
  spec.add_runtime_dependency 'fastimage', ['>= 2.1.5']
end
