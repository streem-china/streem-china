class MarkdownController < ApplicationController
  def preview
    html = Markdowner.render(params[:text])

    sleep 2

    render json: { html: html }
  end
end

