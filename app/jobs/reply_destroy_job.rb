class ReplyDestroyJob < ActiveJob::Base
  queue_as :default

  def perform(reply_id)
    reply = Reply.find_by_id(reply_id)

    reply.destroy if reply
  end
end
