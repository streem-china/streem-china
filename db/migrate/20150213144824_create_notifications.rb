class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :reply_id
      t.integer :mention_id
      t.integer :favorite_id
      t.string :type, null: false
      t.boolean :read, default: false

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, :reply_id
    add_index :notifications, :mention_id
    add_index :notifications, :favorite_id
  end
end
