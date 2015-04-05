class AvatarsController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.update_attributes(avatar: params[:url])

    head :no_content
  end
end
