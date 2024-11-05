# frozen_string_literal: true

require 'uri'
require "nokogiri"

module Jekyll::Spaceship
  class MediaProcessor < Processor
    def self.config
      {
        'default' => {
          'id' => 'media-{id}',
          'class' => 'media',
          'width' => '100%',
          'height' => 350,
          'frameborder' => 0,
          'style' => 'max-width: 600px;outline: none',
          'allow' => 'encrypted-media; picture-in-picture'
        }
      }
    end

    def on_handle_html(content)
      # use nokogiri to parse html content
      doc = Nokogiri::HTML(content)
      # handle each img tag
      doc.css('img').each do |element|
        handle_normal_audio(element)
        handle_normal_video(element)
        handle_youtube(element)
        handle_vimeo(element)
        handle_dailymotion(element)
        handle_spotify(element)
        handle_spotify_podcast(element)
        handle_soundcloud(element)
      end
      doc.to_html
    end

    # Examples:
    # ![audio](//www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3)
    # ![audio](//www.expample.com/examples/t-rex-roar.mp3?autoplay=true&loop=true)
    def handle_normal_audio(element)
      handle_media(element, {
        media_type: 'audio',
        host: '(https?:\\/\\/)?.*\\/',
        id: '(.+?\\.(mp3|wav|ogg|mid|midi|aac|wma))'
      })
    end


    # Examples:
    # ![video](//www.html5rocks.com/en/tutorials/video/basics/devstories.webm)
    # ![video](//techslides.com/demos/sample-videos/small.ogv?allow=autoplay)
    # ![video](//techslides.com/demos/sample-videos/small.mp4?width=400)
    def handle_normal_video(element)
      handle_media(element, {
        media_type: 'video',
        host: '(https?:\\/\\/)?.*\\/',
        id: '(.+?\\.(avi|mp4|webm|ogg|ogv|flv|mkv|mov|wmv|3gp|rmvb|asf))'
      })
    end

    # Examples:
    # ![youtube](https://www.youtube.com/watch?v=XA2WjJbmmoM "title")
    # ![youtube](http://www.youtube.com/embed/w-m_yZCLF5Q)
    # ![youtube](//youtu.be/mEP3YXaSww8?height=100%&width=400)
    def handle_youtube(element)
      handle_media(element, {
        media_type: 'iframe',
        host: '(https?:)?\\/\\/.*youtu.*',
        id: '(?<=\\?v\\=|embed\\/|\\.be\\/)([a-zA-Z0-9\\_\\-]+)',
        base_url: "https://www.youtube.com/embed/"
      })
    end

    # Examples:
    # ![vimeo](https://vimeo.com/263856289)
    # ![vimeo](https://vimeo.com/263856289?height=100%&width=400)
    def handle_vimeo(element)
      handle_media(element, {
        media_type: 'iframe',
        host: '(https?:)?\\/\\/vimeo\\.com\\/',
        id: '([0-9]+)',
        base_url: "https://player.vimeo.com/video/"
      })
    end

    # Examples:
    # ![dailymotion](https://www.dailymotion.com/video/x7tgcev)
    # ![dailymotion](https://dai.ly/x7tgcev?height=100%&width=400)
    def handle_dailymotion(element)
      handle_media(element, {
        media_type: 'iframe',
        host: '(https?:)?\\/\\/(?>www\\.)?dai\\.?ly(?>motion\\.com\\/video)?\\/',
        id: '([a-zA-Z0-9\\_\\-]+)',
        base_url: "https://www.dailymotion.com/embed/video/"
      })
    end

    # Examples:
    # ![spotify](//open.spotify.com/track/4Dg5moVCTqxAb7Wr8Dq2T5)
    # ![spotify](//open.spotify.com/track/37mEkAaqCE7FXMvnlVA8pp?width=400)
    def handle_spotify(element)
      handle_media(element, {
        media_type: 'iframe',
        host: '(https?:)?\\/\\/open\\.spotify\\.com\\/track\\/',
        id: '(?<=track\\/)([a-zA-Z0-9\\_\\-]+)',
        base_url: "https://open.spotify.com/embed/track/",
        height: 80
      })
    end

    # Examples:
    # ![spotify podcast](//open.spotify.com/episode/31AxcwYdjsFtStds5JVWbT)
    # ![spotify podcast](//open.spotify.com/episode/44gfWHnwbmSY7Euw6Nb39k?width=400)
    def handle_spotify_podcast(element)
      handle_media(element, {
        media_type: 'iframe',
        host: '(https?:)?\\/\\/open\\.spotify\\.com\\/episode\\/',
        id: '(?<=episode\\/)([a-zA-Z0-9\\_\\-]+)',
        base_url: "https://open.spotify.com/embed/episode/",
        height: 152
      })
    end

    # Examples:
    # ![soundcloud](//soundcloud.com/aviciiofficial/preview-avicii-vs-lenny)
    def handle_soundcloud(element)
      handle_media(element, {
        media_type: 'iframe',
        id_from: 'html',
        host: '(https?:)?\\/\\/soundcloud\\.com\\/.+\\/[^\\?]+',
        id: '(?<=soundcloud:\\/\\/sounds:)([0-9]+)',
        base_url: "https://w.soundcloud.com/player/?url="\
          "https%3A//api.soundcloud.com/tracks/",
        height: 125,
      })
    end

    def handle_media(element, data)
      host = data[:host]
      src = element.get_attribute('src')
      title = element.get_attribute('title')
      id = data[:id_from] === 'html' ? '()' : data[:id]
      match_data = src&.match(/#{host}#{id}\S*/)
      return if match_data.nil?

      media_type = data[:media_type]
      base_url = data[:base_url]
      id = data[:id_from] === 'html' \
        ? get_id_from_html(src, data[:id]) \
        : match_data[2]
      qs = src.match(/(?<=\?)(\S*?)$/)
      qs = Hash[URI.decode_www_form(qs.to_s)].reject do |k, v|
        next true if v == id or v == ''
      end

      cfg = self.config['default'].clone
      cfg['id'] = qs['id'] || cfg['id']
      cfg['class'] = qs['class'] || cfg['class']
      cfg['style'] = qs['style'] || cfg['style']
      cfg['id'] = cfg['id'].gsub('{id}', id)
      cfg['class'] = cfg['class'].gsub('{id}', id)

      cfg['src'] = URI(base_url ? "#{base_url}#{id}" : src).tap do |v|
        v.query = URI.encode_www_form(qs) if qs.size > 0
      end

      case media_type
      when 'audio'
        cfg['autoplay'] = qs['autoplay'] || data[:autoplay] || cfg['autoplay']
        cfg['loop'] = qs['loop'] || data[:loop] || cfg['loop']
        cfg['style'] += ';display: none;' if qs['hidden']
        handle_audio(element, { cfg: cfg })
      when 'video'
        cfg['autoplay'] = qs['autoplay'] || data[:autoplay] || cfg['autoplay']
        cfg['loop'] = qs['loop'] || data[:loop] || cfg['loop']
        handle_video(element, { cfg: cfg })
      when 'iframe'
        cfg['title'] = title
        cfg['width'] = qs['width'] || data[:width] || cfg['width']
        cfg['height'] = qs['height'] || data[:height] || cfg['height']
        cfg['frameborder'] = qs['frameborder'] || cfg['frameborder']
        cfg['allow'] ||= cfg['allow']
        handle_iframe(element, { cfg: cfg })
      end
      self.handled = true
    end

    def handle_audio(element, data)
      cfg = data[:cfg]
      html = "<audio"\
        " id=\"#{cfg['id']}\""\
        " class=\"#{cfg['class']}\""\
        " #{cfg['autoplay'] ? 'autoplay' : ''}"\
        " #{cfg['loop'] ? 'loop' : ''}"\
        " src=\"#{cfg['src']}\""\
        " style=\"#{cfg['style']}\""\
        " controls>" \
        " Your browser doesn't support HTML5 audio."\
        " Here is a <a href=\"#{cfg['src']}\">link to download the audio</a>"\
        " instead."\
        "</audio>"
      doc = Nokogiri::HTML(html)
      return if element.parent.nil?
      element.replace(doc.at('body').children.first)
    end

    def handle_video(element, data)
      cfg = data[:cfg]
      html = "<video"\
        " id=\"#{cfg['id']}\""\
        " class=\"#{cfg['class']}\""\
        " style=\"#{cfg['style']}\""\
        " #{cfg['autoplay'] ? 'autoplay' : ''}"\
        " #{cfg['loop'] ? 'loop' : ''}"\
        " controls>" \
        " <source src=\"#{cfg['src']}\">" \
        " Your browser doesn't support HTML5 video."\
        " Here is a <a href=\"#{cfg['src']}\">link to download the video</a>"\
        " instead."\
        "</video>"
      doc = Nokogiri::HTML(html)
      return if element.parent.nil?
      element.replace(doc.at('body').children.first)
    end

    def handle_iframe(element, data)
      cfg = data[:cfg]
      html = "<iframe"\
        " id=\"#{cfg['id']}\""\
        " class=\"#{cfg['class']}\""\
        " src=\"#{cfg['src']}\""\
        " title=\"#{cfg['title']}\""\
        " width=\"#{cfg['width']}\""\
        " height=\"#{cfg['height']}\""\
        " style=\"#{cfg['style']}\""\
        " allow=\"#{cfg['allow']}\""\
        " frameborder=\"#{cfg['frameborder']}\""\
        " allowfullscreen>"\
        "</iframe>"
      doc = Nokogiri::HTML(html)
      return if element.parent.nil?
      element.replace(doc.at('body').children.first)
    end

    def get_id_from_html(url, pattern)
      id = ''
      begin
        url = 'https:' + url if url.start_with? '//'
        res = Net::HTTP.get_response URI(url)
        raise res.body unless res.is_a?(Net::HTTPSuccess)
        res.body.match pattern do |match_data|
          id = match_data[0]
          break
        end
      rescue StandardError => msg
        data = url
        logger.log msg
      end
      id
    end
  end
end
