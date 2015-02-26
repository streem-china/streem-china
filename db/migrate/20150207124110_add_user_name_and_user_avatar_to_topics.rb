class AddUserNameAndUserAvatarToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :user_name, :string, null: false
    add_column :topics, :user_avatar, :string, null: false
  end
end
