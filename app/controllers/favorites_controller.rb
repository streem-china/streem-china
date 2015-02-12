class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.favorites.create(
      favoritable_id: params[:favoritable_id],
      favoritable_type: params[:favoritable_type]
    )
  end

  def destroy
    current_user.favorites.where(
      favoritable_id: params[:favoritable_id],
      favoritable_type: params[:favoritable_type]
    ).first.destroy
  end
end
