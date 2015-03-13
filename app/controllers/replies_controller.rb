class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action { @topbar = :community }

  def create
    @reply = current_user.replies.new(reply_params)

    @reply.save
  end

  def edit
    @reply = current_user.replies.find(params[:id])
  end

  def destroy
    @reply = current_user.replies.find(params[:id]).destroy

    head :no_content
  end

  def update
    @reply = current_user.replies.find(params[:id])

    if @reply.update_attributes(reply_params)
      page = Reply.page_of_floor(@reply.floor)

      flash[:success] = t('reply.updated_success')

      redirect_to topic_path(@reply.topic, page: page, anchor: "reply-#{@reply.floor}")
    else
      flash.now[:alert] = @reply.errors.full_messages.join(', ')

      render :edit
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:topic_id, :body)
  end
end
