class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id, null: false
      t.integer :node_id, null: false
      t.integer :replies_count, null: false, default: 0
      t.integer :favorites_count, null: false, default: 0
      t.integer :last_replied_user_id
      t.string :node_name, null: false
      t.string :title, null: false
      t.string :last_replied_user_name
      t.string :user_name, null: false
      t.string :user_avatar, null: false
      t.datetime :actived_at, null: false
      t.datetime :last_replied_at
      t.text :body, null: false
      t.text :body_html, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :topics, :user_id
  end
end
