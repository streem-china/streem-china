class MarkdownController < ApplicationController
  def preview
    html = Markdowner.render(params[:text])

    render json: { html: html }
  end
end

