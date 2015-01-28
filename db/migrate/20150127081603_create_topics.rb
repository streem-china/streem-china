class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :replies_count, default: 0, null: false
      t.integer :last_replied_user_id, default: nil
      t.datetime :last_replied_at, default: nil

      t.timestamps null: false
    end

    add_index :topics, :last_replied_at
  end
end
