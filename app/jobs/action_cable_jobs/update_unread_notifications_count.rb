module ActionCableJobs
  class UpdateUnreadNotificationsCount < ActiveJob::Base
    queue_as :actioncable

    def perform(user_id)
      user = User.find(user_id)

      ActionCable.server.broadcast "notifications_#{user.id}",
        { unread_notifications_count: user.unread_notifications_count }
    end
  end
end
