class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :topic_id, null: false
      t.integer :user_id, null: false
      t.text :body

      t.timestamps null: false
    end

    add_index :replies, :topic_id
  end
end
