# frozen_string_literal: true

require 'jekyll-spaceship/cores/logger'
require 'jekyll-spaceship/cores/config'
require 'jekyll-spaceship/cores/manager'
require 'jekyll-spaceship/cores/processor'
require 'jekyll-spaceship/cores/register'

module Jekyll::Spaceship
  Logger.display_info
  Config.load_config
end
