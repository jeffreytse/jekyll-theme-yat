# frozen_string_literal: true

module Jekyll::Spaceship
  class Processor
    DEFAULT_PRIORITY = 20

    PRIORITY_MAP = {
      :lowest  => 0,
      :low     => 10,
      :normal  => 20,
      :high    => 30,
      :highest => 40,
    }.freeze

    @@_registers = []
    @@_exclusions = []
    @@_priority = nil

    attr_reader :page
    attr_reader :logger
    attr_reader :config
    attr_reader :priority
    attr_reader :registers
    attr_reader :exclusions
    attr_accessor :handled

    def name
      self.class.class_name
    end

    def self.class_name
      self.name.split('::').last
    end

    def filename
      self.name
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1-\2')
        .gsub(/([a-z\d])([A-Z])/,'\1-\2')
        .tr("_", "-")
        .downcase
    end

    def initialize()
      self.initialize_priority
      self.initialize_register
      self.initialize_exclusions
      @logger = Logger.new(self.name)
      @config = Config.store(self.filename, self.class.config)
      @handled_files = {}
    end

    def initialize_priority
      @priority = @@_priority
      unless @priority.nil? or @priority.is_a? Numeric
        @priority = PRIORITY_MAP[@priority.to_sym]
      end
      @priority = DEFAULT_PRIORITY if @priority.nil?
      @@_priority = nil
    end

    def initialize_register
      if @@_registers.size.zero?
        self.class.register :pages, :pre_render, :post_render
        self.class.register :documents, :pre_render, :post_render
      end
      @registers = Array.new @@_registers
      @@_registers.clear
    end

    def initialize_exclusions
      if @@_exclusions.size.zero?
        self.class.exclude :code, :math, :liquid_filter
      end
      @exclusions = @@_exclusions.uniq
      @@_exclusions.clear
    end

    def self.priority(value)
      @@_priority = value.to_sym
    end

    def self.register(container, *events)
      @@_registers << [container, events]
    end

    def self.exclude(*types)
      @@_exclusions = types
    end

    def self.config
    end

    def next?
      true
    end

    def process?
      Type.html?(output_ext) or Type.markdown?(ext)
    end

    def ext
      Manager.ext @page
    end

    def output_ext
      Manager.output_ext @page
    end

    def converter(name)
      Manager.converter @page, name
    end

    def dispatch(page, container, event)
      @page = page
      @handled = false
      return unless self.process?
      method = "on_#{container}_#{event}"
      self.send method, @page if self.respond_to? method
      method = ''
      if event.to_s.start_with?('pre')
        if Type.markdown? ext
          method = 'on_handle_markdown'
        end
        if self.respond_to? method
          @page.content = self.pre_exclude @page.content
          @page.content = self.send method, @page.content
          @page.content = self.post_exclude @page.content
        end
      else
        if Type.html? output_ext
          method = 'on_handle_html'
        elsif Type.css? output_ext
          method = 'on_handle_css'
        end
        if self.respond_to? method
          @page.output = self.send method, @page.output
          if Type.html? output_ext
            @page.output = self.class.escape_html(@page.output)
          end
        end
      end
    end

    def on_handle_html_block(content, type)
      # default handle method
      content
    end

    def on_handle_html(content)
      # default handle method
      content
    end

    def on_handled
      source = page.site.source
      file = page.path.sub(/^#{source}\//, '')
      return if @handled_files.has_key? file
      @handled_files[file] = true
      logger.log file
    end

    def exclusion_regexs()
      regexs = []
      @exclusions.each do |type|
        regex = nil
        if type == :code
          regex = /(((?<!\\)`+)\s*(\w*)((?:.|\n)*?)\2)/
        elsif type == :math
          regex = /(((?<!\\)\${1,2})[^\n]*?\1)/
        elsif type == :liquid_filter
          regex = /((?<!\\)((\{\{[^\n]*?\}\})|(\{%[^\n]*?%\})))/
        end
        regexs.push regex unless regex.nil?
      end
      regexs
    end

    def pre_exclude(content, regexs = self.exclusion_regexs())
      @exclusion_store = []
      regexs.each do |regex|
        content.scan(regex) do |match_data|
          match = match_data[0]
          id = @exclusion_store.size
          content = content.sub(match, "<!JEKYLL@#{object_id}@#{id}>")
          @exclusion_store.push match
        end
      end
      content
    end

    def post_exclude(content)
      while @exclusion_store.size > 0
        match = @exclusion_store.pop
        id = @exclusion_store.size
        content = content.sub(
          "<!JEKYLL@#{object_id}@#{id}>"
        ) { match }
      end
      @exclusion_store = []
      content
    end

    def get_exclusion(id)
      result = nil
      match_data = id.match /<!JEKYLL@(.+)@(.+)>/
      unless match_data.nil?
        id = match_data[2].to_i
        result = {
          :id => id,
          :marker => match_data[0],
          :content => @exclusion_store[id]
        }
      end
      result
    end

    def self.escape_html(content)
      # escape link
      content.scan(/((https?:)?\/\/\S+\?[a-zA-Z0-9%\-_=\.&;]+)/) do |result|
        result = result[0]
        link = result.gsub('&amp;', '&')
        content = content.gsub(result, link)
      end
      content
    end

    def self.fetch_img_data(url)
      begin
        res = Net::HTTP.get_response URI(url)
        raise res.body unless res.is_a?(Net::HTTPSuccess)
        content_type = res.header['Content-Type']
        raise 'Unknown content type!' if content_type.nil?
        content_body = res.body.force_encoding('UTF-8')
        return {
          'type' => content_type,
          'body' => content_body
        }
      rescue StandardError => msg
        logger = Logger.new(self.class_name)
        logger.log msg
      end
    end

    def self.make_img_tag(data)
      css_class = data['class']
      type = data['type']
      body = data['body']
      if type == 'url'
        "<img class=\"#{css_class}\" src=\"#{body}\">"
      elsif type.include?('svg')
        body.gsub(/\<\?xml.*?\?>/, '')
          .gsub(/<!--[^\0]*?-->/, '')
          .sub(/<svg /, "<svg class=\"#{css_class}\" ")
      else
        body = Base64.encode64(body)
        body = "data:#{type};base64, #{body}"
        "<img class=\"#{css_class}\" src=\"#{body}\">"
      end
    end

    def self.handle_bang_link(
      content,
      url = '(https?:)?\\/\\/.*',
      title = '("(.*)".*){0,1}',
      &block
    )
      # pre-handle reference-style links
      regex = /(\[(.*)\]:\s*(#{url}\s*#{title}))/
      content.scan regex do |match_data|
        match = match_data[0]
        ref_name = match_data[1]
        ref_value = match_data[2]
        content = content.gsub(match, '')
          .gsub(/\!\[(.*)\]\s*\[#{ref_name}\]/,
            "![\1](#{ref_value})")
      end

      # handle inline-style links
      regex = /(\!\[(.*)\]\(.*#{url}\s*#{title}\))/
      content.scan regex do |match_data|
        url = match_data[2]
        title = match_data[6]
        block.call(url, title)
      end
    end
  end
end
