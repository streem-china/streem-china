class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :reply_id
      t.integer :mention_id
      t.string :type, null: false
      t.boolean :read, default: false
    end

    add_index :notifications, :user_id
  end
end
