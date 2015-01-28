class TopicsController < ApplicationController
  def index
    page = params[:page] || 1

    @topics = Topic.order('id desc').paginate(page: page)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:success] = '帖子发布成功'

      redirect_to topics_path
    else
      flash.now[:error] = @topic.errors.full_messages.join(', ')

      render :new
    end
  end

  def show
    page = params[:page] || 1

    @topic = Topic.find(params[:id])

    @replies = @topic.replies.paginate(page: page)
  end

  def edit
    @topic = current_user.topics.find(params[:id])
  end

  def update
    @topic = current_user.topics.find(params[:id])

    if @topic.update_attributes(topic_params)
      flash[:success] = '帖子更新成功'

      redirect_to topics_path
    else
      flash.now[:error] = @topic.errors.full_messages.join(', ')

      render :new
    end
  end

  def destroy
    flash[:success] = '帖子删除成功'

    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
