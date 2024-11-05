# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-spaceship/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-spaceship"
  spec.version       = Jekyll::Spaceship::VERSION
  spec.authors       = ["jeffreytse"]
  spec.email         = ["jeffreytse.mail@gmail.com"]
  spec.summary       = "A Jekyll plugin to provide powerful supports for table, mathjax, plantuml, mermaid, emoji, video, audio, youtube, vimeo, dailymotion, spotify, soundcloud, etc."
  spec.homepage      = "https://github.com/jeffreytse/jekyll-spaceship"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_dependency "jekyll", ">= 3.6", "< 5.0"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "gemoji", "~> 3.0"
  spec.add_dependency "rainbow", "~> 3.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
