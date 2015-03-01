class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.
      notifications.
      order('read asc, id desc').
      paginate(page: params[:page])

    unread = @notifications.select(&:unread?)

    if unread.present?
      current_user.notifications.where(id: unread.map(&:id)).each(&:read!)

      unread.each { |n| n.read = false }
    end
  end
end
