class AddNotificationsCountAndUnreadNotificationsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notifications_count, :integer, default: 0
    add_column :users, :unread_notifications_count, :integer, default: 0
  end
end
