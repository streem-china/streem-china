class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favoritable = params[:favoritable_type].constantize.find_by_id(params[:favoritable_id])

    if favoritable
      current_user.favorites.create(
        favoritable_id: params[:favoritable_id],
        favoritable_type: params[:favoritable_type]
      )

      head :created
    else
      head :bad_request
    end
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
