# frozen_string_literal: true

module Jekyll::Spaceship
  class Type
    HTML_EXTENSIONS = %w(
      .html
      .xhtml
      .htm
    ).freeze

    CSS_EXTENSIONS = %w(
      .css
      .scss
    ).freeze

    MD_EXTENSIONS = %w(
      .md
      .markdown
    ).freeze

    HTML_BLOCK_TYPE_MAP = {
      'text/markdown'  => 'markdown',
    }.freeze

    def self.html?(_ext)
      HTML_EXTENSIONS.include?(_ext)
    end

    def self.css?(_ext)
      CSS_EXTENSIONS.include?(_ext)
    end

    def self.markdown?(_ext)
      MD_EXTENSIONS.include?(_ext)
    end

    def self.html_block_type(type)
      HTML_BLOCK_TYPE_MAP[type]
    end
  end
end
