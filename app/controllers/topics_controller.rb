class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @topics = Topic.order('actived_at desc').paginate(page: params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:success] = '发布成功'

      redirect_to topics_path
    else
      flash.now[:error] = @topic.errors.full_messages.join(', ')

      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])

    current_user.update_read_topic(@topic) if current_user

    @replies = @topic.replies.with_deleted.paginate(page: params[:page])
  end

  def edit
    @topic = current_user.topics.find(params[:id])
  end

  def update
    @topic = current_user.topics.find(params[:id])

    if @topic.update_attributes(topic_params)
      flash[:success] = '更新成功'

      redirect_to topic_path(@topic)
    else
      flash.now[:error] = @topic.errors.full_messages.join(', ')

      render :edit
    end
  end

  def destroy
    @topic = current_user.topics.find(params[:id]).destroy

    flash[:success] = '删除成功'

    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
