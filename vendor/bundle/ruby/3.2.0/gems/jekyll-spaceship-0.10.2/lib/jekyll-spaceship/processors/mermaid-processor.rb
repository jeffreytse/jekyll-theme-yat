# frozen_string_literal: true

require "net/http"
require "base64"

module Jekyll::Spaceship
  class MermaidProcessor < Processor
    exclude :none

    def self.config
      {
        'mode' => 'default',
        'syntax' => {
          'code' => 'mermaid!',
          'custom' => ['@startmermaid', '@endmermaid']
        },
        'css' => {
          'class' => 'mermaid'
        },
        'config': {
          'theme' => 'default'
        },
        'src' => 'https://mermaid.ink/svg/'
      }
    end

    def on_handle_markdown(content)
      # match custom mermaid block and code block
      syntax = self.config['syntax']
      code_name = syntax['code']
      custom = syntax['custom'][-2, 2]

      patterns = [
        /((`{3,})\s*#{code_name}((?:.|\n)*?)\2)/,
        /((?<!\\)(#{custom[0]})((?:.|\n)*?)(?<!\\)(#{custom[1]}))/
      ]

      patterns.each do |pattern|
        content = handle_mermaid_block(pattern, content)
      end

      # handle escape custom mermaid block
      content.gsub(/\\(#{custom[0]}|#{custom[1]})/, '\1')
    end

    def handle_mermaid_block(pattern, content)
      content.scan pattern do |match|
        match = match.select { |m| not m.nil? }
        block = match[0]
        code = match[2]

        self.handled = true

        content = content.gsub(
          block,
          handle_mermaid(code)
        )
      end
      content
    end

    def handle_mermaid(code)
      # Handle extra empty lines, otherwise it would cause error
      code = code.gsub(/\n\s*\n/, "\n%%-\n")

      # encode to UTF-8
      code = code.encode('UTF-8')
      url = get_url(code)

      # render mode
      case self.config['mode']
      when 'pre-fetch'
        data = self.class.fetch_img_data(url)
      end
      if data.nil?
        data = { 'type' => 'url', 'body' => url }
      end

      # return img tag
      data['class'] = self.config['css']['class']
      self.class.make_img_tag(data)
    end

    def get_url(code)
      src = self.config['src']

      # wrap code
      code = {
        'code' => code.gsub(/^\s*|\s*$/, ''),
        'mermaid' => config['config']
      }.to_json

      # set default method
      src += '{code}' if src.match(/\{.*\}/).nil?

      # encode to base64 string
      if src.include?('{code}')
        code = Base64.urlsafe_encode64(code, padding: false)
        return src.gsub('{code}', code)
      else
        raise "No supported src ! #{src}"
      end
    end
  end
end
