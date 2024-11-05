# frozen_string_literal: true

require 'jekyll-spaceship/version'
require 'rainbow/refinement'

using Rainbow

module Jekyll::Spaceship
  class Logger
    def initialize(namespace)
      @namespace = namespace
    end

    def self.display_info
      self.log "🚀 Jekyll-Spaceship #{Jekyll::Spaceship::VERSION}"
      self.log '🎉 A Jekyll plugin to provide powerful supports.'
      self.log '👉 ' + 'https://github.com/jeffreytse/jekyll-spaceship'.underline
    end

    def self.log(content)
      self.output 'Jekyll Spaceship', content.bright
    end

    def self.output(title, content)
      puts "#{title.rjust(18)}: #{content}"
    end

    def log(content)
      if @namespace.nil?
        self.class.log content
      else
        self.class.log "[#{@namespace}] #{content}"
      end
    end
  end
end
