class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :location
      t.string :company
      t.string :blog_link
      t.string :github_link
      t.string :twitter_link

      t.timestamps null: false
    end

    add_index :profiles, :user_id
  end
end
