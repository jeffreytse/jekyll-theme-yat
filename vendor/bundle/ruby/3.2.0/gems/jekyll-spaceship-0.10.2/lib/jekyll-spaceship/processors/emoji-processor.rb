# frozen_string_literal: true

require 'net/http'
require 'json'
require 'gemoji'

module Jekyll::Spaceship
  class EmojiProcessor < Processor
    def self.config
      {
        'css' => {
          'class' => 'emoji'
        },
        'src' => 'https://github.githubassets.com/images/icons/emoji/'
      }
    end

    def on_handle_html(content)
      emoji_filter(content, 'pre code') do |emoji|
        # mark current file has been handled
        self.handled = true

        # here is the replacement content
        "<img class=\"#{config['css']['class']}\""\
          " title=\":#{emoji.name}:\""\
          " alt=\":#{emoji.name}:\""\
          " raw=\"#{emoji.raw}\""\
          " src=\"#{config['src']}#{emoji.image_filename}\""\
          " style=\"vertical-align: middle; display: inline;"\
          " max-width: 1em; visibility: hidden;\""\
          " onload=\"this.style.visibility='visible'\""\
          " onerror=\"this.replaceWith(this.getAttribute('raw'))\">"\
          "</img>"
      end
    end

    def emoji_filter(content, selector)
      # use nokogiri to parse html
      doc = Nokogiri::HTML(content)

      body = doc.at('body')

      # in case of a page has no the body node, especially when your
      # page's layout field of front matter is nil or unavailable
      return content if body.nil?

      # Count for restoration
      escaped_count = 0

      # filter nodes (pre, code)
      body.css(selector).each do |node|
        count = escaped_count

        # handle emoji markup
        inner_html = node.inner_html.gsub(
          /(?<!\\):([\w\d+-]+?)(?<!\\):/
        ) do |match|
          escaped_count += 1
          "\\:#{match[1..-2]}\\:"
        end

        if escaped_count > count
          node.inner_html = inner_html
        end
      end

      # parse the emoji
      content = body.inner_html
      content.scan(/(?<!\\):([\w\d+-]+?)(?<!\\):/) do |match|
        # Skip invalid emoji name
        emoji = Emoji.find_by_alias match[0]
        next if emoji.nil?

        # escape plus sign
        emoji_name = emoji.name.gsub('+', '\\\+')

        result = yield emoji
        next if result.nil?

        content = content.gsub(
          /(?<!\=")\s*:#{emoji_name}:\s*(?!"\s)/,
          result)
      end

      body.inner_html = content

      return doc.to_html if escaped_count.zero?

      # restore nodes (pre, code)
      body.css(selector).each do |node|
        # handle emoji markup
        node.inner_html = node.inner_html.gsub(
          /\\:([\w\d+-]+?)\\:/, ':\1:'
        )
      end

      doc.to_html
    end
  end
end
