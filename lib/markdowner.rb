class Markdowner
  class << self
    def render(body)
      html = markdowner.render(body)
    end

    private

    def markdowner
      @markdowner ||=
        Redcarpet::Markdown.new(renderer,
         autolink: true,
         fenced_code_blocks: true,
         strikethrough: true,
         space_after_headers: true,
         no_intra_emphasis: true,
         tables: true)
    end

    def renderer
      @renderer ||= CustomRenderer.new(link_attributes: { target: :_blank })
    end
  end

  class CustomRenderer < Redcarpet::Render::HTML
    require 'rouge/plugins/redcarpet'

    include Rouge::Plugins::Redcarpet

    def paragraph(text)
      parse_user_name(text)
      parse_reply_floor(text)
      parse_emoji(text)

      "<p>#{text}</p>"
    end

    def image(link, title, alt_text)
      "<a href='#{link}' target='_blank'><img src='#{link}' alt='#{alt_text}'></a>"
    end

    private

    def parse_user_name(text)
      text.gsub!(/@(\w+)/) do |match|
        %(<a href='/#{$1}'> #{match} </a>)
      end
    end

    def parse_reply_floor(text)
      floor_name = I18n.t('reply.floor')

      text.gsub!(/#(\d+)\s?#{floor_name}/) do |match|
        page = Reply.page_of_floor($1.to_i)

        %(<a href='?page=#{page}\#reply-#{$1}'> #{match} </a>)
      end
    end

    def parse_emoji(text)
      text.gsub!(/:([\w+-]+):/) do |match|
        if emoji = Emoji.find_by_alias($1)
          image_path = "/images/emoji/#{emoji.image_filename}"
          size = "width='16' height='16'"
          style = 'vertical-align: middle'

          %(<img alt='#$1' src='#{image_path}' style=#{style} #{size} />)
        else
          match
        end
      end
    end
  end
end
