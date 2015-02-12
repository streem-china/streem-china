class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :favoritable_type, null: false
      t.integer :favoritable_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :favorites, [:user_id, :favoritable_id, :favoritable_type], unique: true, name: :user_favoritable
  end
end
