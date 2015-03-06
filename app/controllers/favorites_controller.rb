class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.create(
      favoritable_id: params[:favoritable_id],
      favoritable_type: params[:favoritable_type]
    )
  end

  def destroy
    if params[:id]
      @favorite = current_user.favorites.find(params[:id])
    else
      @favorite = current_user.favorites.where(
        favoritable_id: params[:favoritable_id],
        favoritable_type: params[:favoritable_type]
      ).first
    end
    if @favorite
      @favorite.destroy
    else
      head :not_found
    end
  end
end
