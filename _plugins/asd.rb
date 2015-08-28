require 'open-uri'
require 'nokogiri'
module Jekyll
  class MPTag < Liquid::Tag

      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
        @ft   = markup.split(' ')[0]
        @lb   = markup.split("'")[1]
        html = 'https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=84ad7df61b82e136a98bbf99fa997b3e&photo_id='+@ft
        @best = {
          :sizes => {}
        }
        page = Nokogiri::HTML(open(html))
        page.css("size[label='#{@lb}']").each do |el|
          puts el
          @best = {
            :width => el['width'],
            :height => el['height'],
            :source => el['source'],
            :url => el['url'],
            :media => el['media']
          }
         

          
        end
      end

      # подключаем Nokogiri
      def render(context)
        "#{@lb}+#{@best}<br><img src='#{@best[:source]}'>"
      end
      


  end
end

Liquid::Template.register_tag('m_p', Jekyll::MPTag)

