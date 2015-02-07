class AddUserNameAndUserAvatarToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :user_name, :string
    add_column :topics, :user_avatar, :string
  end
end
