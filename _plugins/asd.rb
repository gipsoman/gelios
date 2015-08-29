require 'open-uri'
require 'nokogiri'
module Jekyll
  class MainPhotoTag < Liquid::Tag

      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
        @ft   = markup.split(' ')[0]
        @lb   = markup.split("'")[1]
        
        end

        # подключаем Nokogiri
        def render(context)
          @api_key = context.registers[:site].config["flickr"]["api_key"]
          
          page = Nokogiri::HTML(open("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=#{@api_key}&photo_id=#{@ft}"))
          page.css("size[label='#{@lb}']").each do |el|
         
            @foto = {
              :width => el['width'],
              :height => el['height'],
              :source => el['source'],
              :url => el['url'],
              :media => el['media']
            }
          @f_url = page.css("size")[7]['source']
          end
          doc = Nokogiri::HTML(open("https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=#{@api_key}&photo_id=#{@ft}"))
          doc.css("photo").each do |link|
            @f_info = {
              :title => doc.css('title').inner_text,
              :description => doc.css('description').inner_text
            }

          end
          
          "<a href=\"#{@f_url}\" alt=\"#{@f_info[:title]}\" media=\"#{@foto[:media]}\"><img src=\"#{@foto[:source]}\" width=\"#{@foto[:width]}\" height=\"#{@foto[:height]}\"></a>"
      
        end

  end
end

Liquid::Template.register_tag('main_photo', Jekyll::MainPhotoTag)

