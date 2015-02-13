class AddTopicsCountAndRepliesCountAndFavoritesCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :topics_count, :integer, default: 0
    add_column :users, :replies_count, :integer, default: 0
    add_column :users, :favorites_count, :integer, default: 0
  end
end
