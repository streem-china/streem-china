class AddUserNameAndUserAvatarToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :user_name, :string, null: false
    add_column :replies, :user_avatar, :string, null: false
  end
end
