# frozen_string_literal: true

require 'nokogiri'
require __dir__ + '/type'

module Jekyll::Spaceship
  class Manager
    @@_hooks = {}
    @@_processors = []

    def self.add(processor)
      # register for listening event
      processor.registers.each do |_register|
        container = _register.first
        events = _register.last.uniq
        events = events.select do |event|
          next true if event.match(/^after/)
          next true if event.match(/^post/)
          next events.index(event.to_s.gsub(/^pre/, 'post').to_sym).nil?
        end
        events.each do |event|
          self.hook container, event
        end
      end
      @@_processors.push(processor)
      @@_processors = @@_processors.sort { |a, b| b.priority <=> a.priority }
    end

    def self.hook(container, event, &block)
      return if not is_hooked? container, event

      handler = ->(page) {
        self.dispatch page, container, event
        block.call if block
      }

      if event.to_s.start_with?('after')
        Jekyll::Hooks.register container, event do |page|
          handler.call page
        end
      elsif event.to_s.start_with?('post')
        Jekyll::Hooks.register container, event do |page|
          handler.call page
        end
        # auto add pre-event
        self.hook container, event.to_s.sub('post', 'pre').to_sym
      elsif event.to_s.start_with?('pre')
        Jekyll::Hooks.register container, event do |page|
          handler.call page
        end
      end
    end

    def self.is_hooked?(container, event)
      hook_name = "#{container}_#{event}".to_sym
      return false if @@_hooks.has_key? hook_name
      @@_hooks[hook_name] = true
    end

    def self.dispatch(page, container, event)
      # dispatch to each processor
      @@_processors.each do |processor|
        processor.dispatch page, container, event
        break unless processor.next?
      end
      if event.to_s.start_with?('post') and Type.html? output_ext(page)
        self.dispatch_html_block(page)
      end
      # update page excerpt
      @@_processors.each do |processor|
        next unless processor.handled
        next unless page.is_a? Jekyll::Document
        break page.data['excerpt'] = Jekyll::Excerpt.new(page)
      end
      # call on_handled
      @@_processors.each do |processor|
        processor.on_handled if processor.handled
        break unless processor.next?
      end
    end

    def self.ext(page)
      return unless page.respond_to? :path
      ext = page.path.match(/\.[^.]+$/)
      ext.to_s.rstrip
    end

    def self.output_ext(page)
      return unless page.respond_to? :url_placeholders
      page.url_placeholders[:output_ext]
    end

    def self.converter(page, name)
      page.site.converters.each do |converter|
        class_name = converter.class.to_s.downcase
        return converter if class_name.end_with?(name.downcase)
      end
    end

    def self.dispatch_html_block(page)
      doc = Nokogiri::HTML(page.output)
      doc.css('script').each do |node|
        type = Type.html_block_type node['type']
        content = node.content
        next if type.nil?

        # dispatch to on_handle_html_block
        @@_processors.each do |processor|
          next unless processor.process?
          content = processor.on_handle_html_block content, type
          # dispatch to type handlers
          method = "on_handle_#{type}"
          next unless processor.respond_to? method
          content = processor.pre_exclude content
          content = processor.send method, content
          content = processor.after_exclude content
        end

        cvter = self.converter page, type
        content = cvter.convert content unless cvter.nil?

        # dispatch to on_handle_html
        @@_processors.each do |processor|
          next unless processor.process?
          content = processor.on_handle_html content
        end
        node.replace Nokogiri::HTML.fragment content
      end
      page.output = Processor.escape_html doc.to_html
    end
  end
end
