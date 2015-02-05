class AddActivedAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :actived_at, :datetime
    add_index :topics, :actived_at
  end
end
