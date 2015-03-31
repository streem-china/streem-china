class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action { @topbar = :community }

  def index
    @topics = Topic.without_body.order(actived_at: :desc)

    if params[:node]
      @node = Node.find_by_name(params[:node])

      @topics = @topics.where(node_id: @node.id)
    end

    @topics = @topics.paginate(page: params[:page])
  end

  def new
    node = Node.find_by_name(params[:node]) if params[:node]

    @topic = Topic.new(node: node)
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:success] = t('topic.created_success')

      redirect_to topics_path
    else
      flash.now[:alert] = @topic.errors.full_messages.join(', ')

      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])

    current_user.update_read_topic(@topic) if current_user

    @replies = @topic.replies.with_deleted.order(:floor).paginate(page: params[:page])
  end

  def edit
    @topic = current_user.topics.find(params[:id])
  end

  def update
    @topic = current_user.topics.find(params[:id])

    if @topic.update_attributes(topic_params)
      flash[:success] = t('topic.updated_success')

      redirect_to topic_path(@topic)
    else
      flash.now[:alert] = @topic.errors.full_messages.join(', ')

      render :edit
    end
  end

  def destroy
    @topic = current_user.topics.find(params[:id]).destroy

    flash[:success] = t('topic.deleted_success')

    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end
end
