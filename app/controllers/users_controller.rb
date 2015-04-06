class UsersController < ApplicationController
  before_action { @topbar = :user }

  def show
    @user = User.where('lower(name) = ?', params[:username].downcase).first

    if @user
      @topics = @user.topics.without_body.order('id desc').limit(20)
      @replies = @user.replies.includes(:topic).order('id desc').limit(20)
      @favorites = @user.favorites.order('id desc').limit(20)
    else
      raise ActionController::RoutingError.new('Routing Error')
    end
  end

  def index
    @users = User.order(id: :asc).paginate(page: params[:page], per_page: 50)
  end
end
