class UsersController < ApplicationController
  before_action { @topbar = :user }
  before_action :user, except: :index

  def show
    topics
  end

  def topics
    @topics = user.
      topics.
      without_body.
      order(id: :desc).
      paginate(page: params[:page])

    render :show
  end

  def replies
    @replies = user.
      replies.
      includes(:topic).
      order(id: :desc).
      paginate(page: params[:page])

    render :show
  end

  def favorites
    @favorites = user.favorites.order(id: :desc).paginate(page: params[:page])

    render :show
  end

  def index
    @users = User.order(id: :asc).paginate(page: params[:page], per_page: 50)
  end

  private

  def user
    @user ||= (params[:username].present? &&
               User.where('lower(name) = ?', params[:username].downcase).first) ||
                  (raise ActionController::RoutingError.new('Routing Error'))
  end
end
