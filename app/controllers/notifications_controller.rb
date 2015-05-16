class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.
      notifications.
      order('read asc, id desc').
      paginate(page: params[:page])

    read_notifications(@notifications)
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
