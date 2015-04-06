class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :read_notifications

  def index
    @notifications = current_user.
      notifications.
      order('read asc, id desc').
      paginate(page: params[:page])
  end

  private

  def read_notifications
    unread = @notifications.select(&:unread?)

    if unread.present?
      current_user.notifications.where(id: unread.map(&:id)).each(&:read!)

      unread.each { |n| n.read = false }
    end
  end
end
