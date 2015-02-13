class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :receiver_id, null: false
      t.integer :sender_id, null: false
      t.integer :mentionable_id, null: false
      t.string :mentionable_type, null: false

      t.timestamps null: false
    end

    add_index :mentions, [:sender_id, :mentionable_id, :mentionable_type, :receiver_id], unique: true, name: :user_mentionable
  end
end
