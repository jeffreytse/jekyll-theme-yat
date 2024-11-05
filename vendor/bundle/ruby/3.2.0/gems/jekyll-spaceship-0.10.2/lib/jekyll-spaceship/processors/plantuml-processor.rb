# frozen_string_literal: true

require "net/http"
require "base64"

module Jekyll::Spaceship
  class PlantumlProcessor < Processor
    exclude :none

    def self.config
      {
        'mode' => 'default',
        'syntax' => {
          'code' => 'plantuml!',
          'custom' => ['@startuml', '@enduml']
        },
        'css' => {
          'class' => 'plantuml'
        },
        'src' => 'http://www.plantuml.com/plantuml/svg/'
      }
    end

    def on_handle_markdown(content)
      # match custom plantuml block and code block
      syntax = self.config['syntax']
      code_name = syntax['code']
      custom = syntax['custom'][-2, 2]

      patterns = [
        /((`{3,})\s*#{code_name}((?:.|\n)*?)\2)/,
        /((?<!\\)(#{custom[0]})((?:.|\n)*?)(?<!\\)(#{custom[1]}))/
      ]

      patterns.each do |pattern|
        content = handle_plantuml_block(pattern, content)
      end

      # handle escape custom plantuml block
      content.gsub(/\\(#{custom[0]}|#{custom[1]})/, '\1')
    end

    def handle_plantuml_block(pattern, content)
      content.scan pattern do |match|
        match = match.select { |m| not m.nil? }
        block = match[0]
        code = match[2]

        self.handled = true

        content = content.gsub(
          block,
          handle_plantuml(code)
        )
      end
      content
    end

    def handle_plantuml(code)
      # wrap plantuml code
      code = "@startuml#{code}@enduml".encode('UTF-8')
      url = self.get_url(code)

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

      # set default method
      src += '{hexcode}' if src.match(/\{.*\}/).nil?

      # encode to hex string
      if src.include?('{hexcode}')
        code = '~h' + code.unpack("H*").first
        return src.gsub('{hexcode}', code)
      else
        raise "No supported src ! #{src}"
      end
    end
  end
end
