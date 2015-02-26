class AddActivedAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :actived_at, :datetime, null: false
    add_index :topics, :actived_at
  end
end
