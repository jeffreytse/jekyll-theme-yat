# frozen_string_literal: true

require "ostruct"
require "nokogiri"

module Jekyll::Spaceship
  class TableProcessor < Processor
    ATTR_LIST_PATTERN = /((?<!\\)\{:(?:([A-Za-z]\S*):)?(.*?)(?<!\\)\})/
    ATTR_LIST_REFS = {}

    def on_handle_markdown(content)
      # pre-handle reference-style links
      references = {}
      content.scan(/\n\s*(\[(.*)\]:\s*(\S+(\s+".*?")?))/) do |match_data|
        ref_name = match_data[1]
        ref_value = match_data[2]
        references[ref_name] = ref_value
      end
      if references.size > 0
        content.scan(/[^\n]*(?<!\\)\|[^\n]*/) do |result|
          replace = result
          references.each do |key, val|
            replace = replace.gsub(
                /\[([^\n\]]*?)\]\s*\[#{Regexp.escape(key)}\]/,
                "[\\1](#{val})"
            )
          end
          references.each do |key, val|
            replace = replace.gsub(
              /\[#{Regexp.escape(key)}\](?!\s*\(.*?\))/,
              "[#{key}](#{val})"
            )
          end
          next if result == replace
          content = content.gsub(result, replace)
        end
      end

      # pre-handle row-span
      content = content.gsub(/(?<!\\)(\|[^\n]*\\\s*)\|\s*\n/, "\\1\n")

      # escape | and :
      content = content.gsub(/\|(?=\|)/, '\\|')
        .gsub(/\\:(?=[^\n]*?(?<!\\)\|)/, '\\\\\\\\:')
        .gsub(/((?<!\\)\|[^\n]*?)(\\:)/, '\1\\\\\\\\:')

      # escape * and _ and $ etc.
      content.scan(/[^\n]*(?<!\\)\|[^\n]*/) do |result|
        # skip for math expression within pipeline
        next unless result
          .gsub(/((?<!\\)\${1,2})[^\n]*?\1/, '')
          .match(/(?<!\\)\|/)
        replace = result.gsub(
          /(?<!(?<!\\)\\)(\*|\$|\[(?!\^)|\(|\"|_)/, '\\\\\\\\\1')
        next if result == replace
        content = content.gsub(result, replace)
      end

      # pre-handle attribute list (AL)
      ATTR_LIST_REFS.clear()
      content.scan(ATTR_LIST_PATTERN) do |result|
        ref = result[1]
        list = result[2]
        next if ref.nil?
        if ATTR_LIST_REFS.has_key? ref
          ATTR_LIST_REFS[ref] += list
        else
          ATTR_LIST_REFS[ref] = list
        end
      end
      content
    end

    def on_handle_html(content)
      # use nokogiri to parse html content
      doc = Nokogiri::HTML(content)

      data = self.table_scope_data

      # handle each table
      doc.css('table').each do |table|
        next if table.ancestors('code, pre').size > 0
        rows = table.css('tr')
        data.table = table
        data.rows = rows
        data.reset.call :table
        rows.each do |row|
          cells = row.css('th, td')
          data.row = row
          data.cells = cells
          data.reset.call :row
          cells.each do |cell|
            data.cell = cell
            handle_colspan(data)
            handle_multi_rows(data)
            handle_text_align(data)
            handle_rowspan(data)
          end
        end
        rows.each do |row|
          cells = row.css('th, td')
          cells.each do |cell|
            data.cell = cell
            handle_format(data)
            handle_attr_list(data)
          end
        end
        self.handled = true
      end

      doc.to_html
    end

    def table_scope_data
      data = OpenStruct.new(_: OpenStruct.new)
      data.reset = ->(scope, namespace = nil) {
        data._.marshal_dump.each do |key, val|
          if namespace == key or namespace.nil?
            data._[key][scope] = OpenStruct.new
          end
        end
      }
      data.scope = ->(namespace) {
        if not data._[namespace]
          data._[namespace] = OpenStruct.new(
            table: OpenStruct.new,
            row: OpenStruct.new
          )
        end
        data._[namespace]
      }
      data
    end

    def handle_colspan(data)
      scope = data.scope.call __method__
      cells = data.cells
      cell = data.cell

      if scope.table.row != data.row
        scope.table.row = data.row
        scope.row.colspan = 0
      end

      # handle colspan
      if cell == cells.last and scope.row.colspan > 0
        cells.count.downto(cells.count - scope.row.colspan + 1) do |i|
          c = cells[i - 1]
          return unless c.get_attribute('colspan').nil?
          c.remove
        end
      end

      result = cell.inner_html.match(/(\|)+$/)
      return if result.nil?

      cell.inner_html = cell.inner_html.gsub(/(\|)+$/, '')
      result = result[0]
      colspan = result.scan(/\|/).count
      scope.row.colspan += colspan
      cell.set_attribute('colspan', colspan + 1)
    end

    def handle_multi_rows(data)
      scope = data.scope.call __method__
      cells = data.cells
      row = data.row
      cell = data.cell

      if scope.table.table != data.table
        scope.table.table = data.table
        scope.table.multi_row_cells = nil
        scope.table.multi_row_start = false
      end

      # handle multi-rows
      return if cell != cells.last

      match = cell.content.match(/(?<!\\)\\\s*$/)
      if match
        cell.content = cell.content.gsub(/(?<!\\)\\\s*$/, '')
        if not scope.table.multi_row_start
          scope.table.multi_row_cells = cells
          scope.table.multi_row_start = true
        end
      end

      if scope.table.multi_row_cells != cells and scope.table.multi_row_start
        for i in 0...scope.table.multi_row_cells.count do
          multi_row_cell = scope.table.multi_row_cells[i]
          multi_row_cell.inner_html += "\n<br>\n#{cells[i].inner_html}"
        end
        row.remove
      end
      scope.table.multi_row_start = false if not match
    end

    def handle_rowspan(data)
      scope = data.scope.call __method__
      cell = data.cell
      cells = data.cells

      if scope.table.table != data.table
        scope.table.table = data.table
        scope.table.span_row_cells = []
      end
      if scope.row.row != data.row
        scope.row.row = data.row
        scope.row.col_index = 0
      end

      # handle rowspan
      span_cell = scope.table.span_row_cells[scope.row.col_index]
      if span_cell and cell.inner_html.match(/^\s*\^{2}/)
        cell.inner_html = cell.inner_html.gsub(/^\s*\^{2}/, '')
        span_cell.inner_html += "\n<br>\n#{cell.inner_html}"
        rowspan = span_cell.get_attribute('rowspan') || 1
        rowspan = rowspan.to_i + 1
        span_cell.set_attribute('rowspan', "#{rowspan}")
        cell.remove
      else
        scope.table.span_row_cells[scope.row.col_index] = cell
      end
      scope.row.col_index += [cell.get_attribute('colspan').to_i, 1].max
    end

    def handle_text_align(data)
      cell = data.cell

      # pre-handle text align
      align = 0
      if cell.content.match(/^\s*:(?!:)/)
        cell.content = cell.content.gsub(/^\s*:/, '')
        align += 1
      end
      if cell.content.match(/(?<!\\):\s*$/)
        cell.content = cell.content.gsub(/:\s*$/, '')
        align += 2
      end

      # handle text align
      return if align == 0

      # handle escape colon
      cell.content = cell.content.gsub(/\\:/, ':')

      style = cell.get_attribute('style')
      if align == 1
        align = 'text-align: left'
      elsif align == 2
        align = 'text-align: right'
      elsif align == 3
        align = 'text-align: center'
      end

      # handle existed inline-style
      if style&.match(/text-align:.+/)
        style = style.gsub(/text-align:.+/, align)
      else
        style = align
      end
      cell.set_attribute('style', style)
    end

    # Examples:
    # {:ref-name: .cls1 title="hello" }
    # {: #id ref-name data="world" }
    # {: #id title="hello" }
    # {: .cls style="color: #333" }
    def handle_attr_list(data)
      cell = data.cell
      content = cell.inner_html
      # inline attribute list(IAL) handler
      ial_handler = ->(list) do
        list.scan(/(\S+)=(”|"|')(.*?)\2|(\S+)/) do |attr|
          key = attr[0]
          val = attr[2]
          single = attr[3]
          if !key.nil?
            val = (cell.get_attribute(key) || '') + val
            cell.set_attribute(key, val)
          elsif !single.nil?
            if single.start_with? '#'
              key = 'id'
              val = single[1..-1]
            elsif single.start_with? '.'
              key = 'class'
              val = cell.get_attribute(key) || ''
              val += (val.size.zero? ? '' : ' ') + single[1..-1]
            elsif ATTR_LIST_REFS.has_key? single
              ial_handler.call ATTR_LIST_REFS[single]
            end
            unless key.nil?
              cell.set_attribute(key, val)
            end
          end
        end
      end
      # handle attribute list
      content.scan(ATTR_LIST_PATTERN) do |result|
        ref = result[1]
        list = result[2]
        # handle inline attribute list
        ial_handler.call list if ref.nil?
        # remove attr_list
        content = content.sub(result[0], '')
      end
      cell.inner_html = content
    end

    def handle_format(data)
      cell = data.cell
      cvter = self.converter('markdown')
      return if cvter.nil?
      content = cell.inner_html
      content = self.pre_exclude(content, [/(\<code.*\>.*\<\/code\>)/])
        .gsub(/(?<!\\)\|/, '\\|')
        .gsub(/^\s+|\s+$/, '')
        .gsub(/&lt;/, '<')
        .gsub(/&gt;/, '>')
      content = self.post_exclude(content)
      content = cvter.convert(content)
      content = Nokogiri::HTML.fragment(content)
      if content.children.first&.name == 'p'
        content = content.children
      end
      cell.inner_html = content.inner_html
    end
  end
end
