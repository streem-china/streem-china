class AddFavoritableCountToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :favorites_count, :integer, default: 0
  end
end
