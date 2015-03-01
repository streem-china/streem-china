require 'markdowner'

class MarkdownController < ApplicationController
  def convert
    html = Markdowner.render(params[:text])

    render json: { html: html }
  end
end

