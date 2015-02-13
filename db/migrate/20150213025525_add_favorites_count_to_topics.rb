class AddFavoritesCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :favorites_count, :integer, default: 0
  end
end
