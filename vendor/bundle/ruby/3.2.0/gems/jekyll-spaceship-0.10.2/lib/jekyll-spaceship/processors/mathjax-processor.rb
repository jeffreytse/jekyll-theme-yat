# frozen_string_literal: true

require "nokogiri"

module Jekyll::Spaceship
  class MathjaxProcessor < Processor
    def self.config
      {
        'src' => [
          'https://polyfill.io/v3/polyfill.min.js?features=es6',
          'https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js',
        ],
        'config' => {
          'tex' => {
            'inlineMath' => [['$','$'], ['\\(','\\)']],
            'displayMath' => [['$$','$$'], ['\\[','\\]']]
          },
          'svg': { 'fontCache': 'global' }
        },
        'optimize' => {
          'enabled' => true,
          'include' => [],
          'exclude' => []
        }
      }
    end

    def process?
      return true if Type.html?(output_ext) or Type.markdown?(output_ext)
    end

    def on_handle_markdown(content)
      # pre-handle mathjax expressions in markdown
      patterns = get_math_patterns()
      patterns['include'].each do |pattern|
        content.scan(pattern) do |result|
          expr = result[0]
          body = result[1]
          next if body.size.zero?
          is_excluded = false
          patterns['exclude'].each do |pe|
            break is_excluded = true if expr.match(/#{pe}/)
          end
          next if is_excluded
          escaped_expr = expr
            .gsub(/(?<!^)\\(?!\S$)/, '\\\\\\\\')
            .gsub(/(?<!\\)\$\$/, '\\\$\\\$')
            .gsub(/\\\\(?=\s)/, '\\\\\\\\\\')
            .gsub(/\\ /, '\\\\\\ ')
          content = content.gsub(expr, escaped_expr)
        end
      end
      content
    end

    def on_handle_html(content)
      # use nokogiri to parse html
      doc = Nokogiri::HTML(content)

      head = doc.at('head')
      return content if head.nil?
      return content if not self.has_mathjax_expression? doc

      self.handled = true

      # add mathjax config
      cfg = config['config'].to_json
      head.add_child("<script>MathJax=#{cfg}</script>")

      # add mathjax dependencies
      config['src'] = [config['src']] if config['src'].is_a? String
      config['src'].each do |src|
        head.add_child("<script src=\"#{src}\"></script>")
      end

      doc.to_html
    end

    def has_mathjax_expression?(doc)
      return true unless config['optimize']['enabled'] == true
      scan_mathjax_expression(doc) do
        return true
      end
      false
    end

    def get_math_patterns()
      patterns = []
      math_patterns = []
      ['tex', 'tex2jax'].each do |t|
        ['inlineMath', 'displayMath'].each do |m|
          r = config.dig('config', t, m)
          r&.each do |i|
            btag = Regexp.escape(i[0])
            etag = Regexp.escape(i[1])
            patterns <<= /((?<!\\\\)#{btag}([\s\S]*?)(?<!\\\\)#{etag})/
          end
        end
      end
      config['optimize']['include'].each do |pattern|
        patterns <<= /(#{pattern})/
      end
      {
        'include' => patterns,
        'exclude' => config['optimize']['exclude']
      }
    end

    def scan_mathjax_expression(doc, &block)
      patterns = get_math_patterns()
      doc = doc.clone

      # remove code, pre, figure nodes
      doc.css('body code, body pre, body figure').each do |node|
        node.remove
      end

      # remove scripting mathjax expression
      doc.css('body script').each do |node|
        next if node['type']&.match(/math\/tex/)
        node.remove
      end

      # scan mathjax expressions
      doc.css('body *').each do |node|
        # filter invalid nodes
        next if node.children.size == 0
        invalid = false
        node.children.each do |child|
          unless [
              'text', 'br', 'span',
              'img', 'svg', 'a'
          ].include? child.name
            break invalid = true
          end
        end
        next if invalid

        patterns['include'].each do |pattern|
          # check normal mathjax expression
          node.content.scan(pattern) do |result|
            expr = result[0]
            body = result[1]
            next if body.size.zero?
            is_excluded = false
            patterns['exclude'].each do |pe|
              break is_excluded = true if expr.match(/#{pe}/)
            end
            next if is_excluded
            block.call(node, expr)
          end
        end
      end
    end
  end
end
