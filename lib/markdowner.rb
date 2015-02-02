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
         disable_indented_code_blocks: true,
         space_after_headers: true,
         no_intra_emphasis: true,
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
      "<p>#{emojify(text)}</p>\n"
    end

    private

    def emojify(text)
      text.gsub(/:([\w+-]+):/) do |match|
        if emoji = Emoji.find_by_alias($1)
          image_path = ActionController::Base.helpers.image_path("emoji/#{emoji.image_filename}")
          size       = "width='20' height='20'"
          style      = 'vertical-align: middle'

          %(<img alt='#$1' src='#{image_path}' style=#{style} #{size} />)
        else
          match
        end
      end
    end
  end
end
