class UsersController < ApplicationController
  def show
    @user = User.find_by_name(params[:username])

    if @user
      @topics = @user.topics.without_body.order('id desc').limit(20)
      @replies = @user.replies.order('id desc').limit(20)
      @favorites = @user.favorites.order('id desc').limit(20)
    else
      raise ActionController::RoutingError.new('Routing Error')
    end
  end

  def index
    @users = User.limit(50)
  end
end
