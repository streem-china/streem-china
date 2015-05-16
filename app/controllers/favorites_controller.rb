class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.create(
      favoritable_id: params[:favoritable_id],
      favoritable_type: params[:favoritable_type]
    )

    head :created
  end

  def destroy
    favorite = if params[:id]
                  current_user.favorites.find_by_id(params[:id])
                else
                  current_user.favorites.where(
                    favoritable_id: params[:favoritable_id],
                    favoritable_type: params[:favoritable_type]
                  ).first
                end

    if favorite
      favorite.destroy

      head :no_content
    else
      head :not_found
    end
  end
end
