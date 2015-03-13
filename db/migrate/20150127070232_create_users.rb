class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :avatar
      t.integer :topics_count, null: false, default: 0
      t.integer :replies_count, null: false, default: 0
      t.integer :favorites_count, null: false, default: 0
      t.integer :notifications_count, null: false, default: 0
      t.integer :unread_notifications_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :users, :name, unique: true
  end
end
