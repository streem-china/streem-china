class AddFloorToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :floor, :integer
    add_index :replies, [:topic_id, :floor], unique: true
  end
end
