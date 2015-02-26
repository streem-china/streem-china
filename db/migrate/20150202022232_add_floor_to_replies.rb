class AddFloorToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :floor, :integer, null: false
    add_index :replies, [:topic_id, :floor], unique: true
  end
end
