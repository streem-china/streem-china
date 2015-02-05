class Markdowner
  class << self
    def renderer
      CustomRenderer.new(
        link_attributes: { target: :_blank }
      )
    end

    def markdowner
      @markdowner ||=
        Redcarpet::Markdown.new(renderer,
         autolink: true,
         fenced_code_blocks: true,
         strikethrough: true,
         space_after_headers: true,
         no_intra_emphasis: true,
         no_styles: true,
         table: true)
    end

    def render(body)
      html = markdowner.render(body)
    end
  end

  class CustomRenderer< Redcarpet::Render::HTML
    require 'rouge/plugins/redcarpet'

    include Rouge::Plugins::Redcarpet

    def paragraph(text)
      text = parse_emoji(text)
      text = parse_reply_floor(text)
      text = parse_reply_user_name(text)

      "<p>#{text}</p>\n"
    end

    private

    def parse_reply_floor(text)
      text.gsub(/#(\d+)楼/) do |match|
        %(<a href='\#reply-#{$1}'> #{match} </a>)
      end
    end

    def parse_reply_user_name(text)
      text.gsub(/@([\p{Han}+\w]{2,20})([\s\n\r]+|\Z)/u) do |match|
        %(<a href='/#{$1}'> #{match} </a>)
      end
    end

    def parse_emoji(text)
      text.gsub(/:([\w+-]+):/) do |match|
        if emoji = Emoji.find_by_alias($1)
          image_path = ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}")
          size = "width='20' height='20'"
          style = 'vertical-align: middle'

          %(<img alt='#$1' src='#{image_path}' style=#{style} #{size} />)
        else
          match
        end
      end
    end
  end
end
