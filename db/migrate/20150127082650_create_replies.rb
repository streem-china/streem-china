class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :topic_id, null: false
      t.integer :user_id, null: false
      t.integer :floor, null: false, default: 1
      t.integer :favorites_count, null: false, default: 0
      t.string :user_name, null: false
      t.string :user_avatar, null: false
      t.text :body, null: false
      t.text :body_html, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :replies, :topic_id
    add_index :replies, [:topic_id, :floor], unique: true
  end
end
