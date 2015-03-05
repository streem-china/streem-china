class AddFavoriteIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :favorite_id, :integer
  end
end
