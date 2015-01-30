class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply = current_user.replies.new(reply_params)

    if @reply.save
      flash[:success] = '回复发布成功'

      redirect_to :back
    else
      flash[:error] = @reply.errors.full_messages.join(', ')

      redirect_to :back
    end
  end

  def edit
    @reply = current_user.replies.find(params[:id])
  end

  def destroy
    @reply = current_user.replies.find(params[:id]).destroy
  end

  private

  def reply_params
    params.require(:reply).permit(:topic_id, :body)
  end
end
