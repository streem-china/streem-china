class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.
      notifications.
      order(read: :asc, id: :desc).
      paginate(page: params[:page])

    read_notifications(@notifications)
  end

  def destroy
    notification = Notification::Base.find_by_id(params[:id])

    if notification
      notification.destroy

      head :no_content
    else
      head :not_found
    end
  end

  private

  def read_notifications(notifications)
    unread_notifications = notifications.select(&:unread?)

    notifications.select(&:unread?).each do |unread_notification|
      unread_notification.read!
      unread_notification.read = false
    end
  end
end
