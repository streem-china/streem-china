class AddCreatedAtAndUpdatedAtToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :created_at, :timestamp
    add_column :notifications, :updated_at, :timestamp
  end
end
