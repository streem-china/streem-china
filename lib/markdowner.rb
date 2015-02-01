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
         fenced_code_blocks: true,
         strikethrough: true,
         disable_indented_code_blocks: true,
         space_after_headers: true,
         no_intra_emphasis: true,
         table: true)
    end

    def render(body)
      markdowner.render(body)
    end
  end

  class CustomRenderer< Redcarpet::Render::HTML
    require 'rouge/plugins/redcarpet'

    include Rouge::Plugins::Redcarpet
  end
end
