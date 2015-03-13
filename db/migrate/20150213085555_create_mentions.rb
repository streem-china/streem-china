class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :user_id, null: false
      t.integer :mentionable_id, null: false
      t.string :mentionable_type, null: false

      t.timestamps
    end

    add_index :mentions, [:user_id, :mentionable_id, :mentionable_type], unique: true, name: :user_mentionable
  end
end
