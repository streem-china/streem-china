class AddUserNameAndUserAvatarToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :user_name, :string
    add_column :replies, :user_avatar, :string
  end
end
