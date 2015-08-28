module Jekyll
  class MainPhotoTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
     super
     @markup = markup
     @foto   = markup.split(' ')[0]
     @size = markup.split(' ')[1]
    end
    def render(context)
     @api_key = context.registers[:site].config["flickr"]["api_key"]
      

      "<a data-flickr-embed=\"true\"  href=\"https://www.flickr.com/photos/135036651@N08/#{@foto}/in/album-72157657634209146/\" title=\"vkontakte-vykupila\"><img src=\"https://farm1.staticflickr.com/631/#{@foto}_4a63ab8e0d_#{@size}.jpg\"  alt=\"vkontakte- vykupila\"></a><br/>
      <p>#{@api_key}</p>"
    end
  end
end

Liquid::Template.register_tag('main_photo', Jekyll::MainPhotoTag)