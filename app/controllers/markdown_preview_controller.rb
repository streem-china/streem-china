require 'markdowner'

class MarkdownPreviewController < ApplicationController
  def show
    html = Markdowner.render(params[:text])

    render json: { html: html }
  end
end

