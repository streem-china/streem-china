module ActionCableJobs
  class NotifyUnreadNotificationsCount < ActiveJob::Base
    queue_as :actioncable

    def perform(user_id, user_unread_notifications_count)
      ActionCable.server.broadcast "notifications_#{user_id}",
        { unread_notifications_count: user_unread_notifications_count }
    end
  end
end
