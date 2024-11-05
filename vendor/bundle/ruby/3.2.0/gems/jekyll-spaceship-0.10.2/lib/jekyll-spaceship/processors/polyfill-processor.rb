# frozen_string_literal: true

module Jekyll::Spaceship
  class PolyfillProcessor < Processor
    priority :high

    def on_handle_markdown(content)
      # escape ordered list.
      rexp = /(\s*)(?<!\\)\\(?=\d+\.)/
      self.handled = true if content.match(rexp)
      content.gsub(rexp, '\1&#8291;')
    end
  end
end
