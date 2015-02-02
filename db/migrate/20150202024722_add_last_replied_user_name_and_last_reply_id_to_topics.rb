class AddLastRepliedUserNameAndLastReplyIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_replied_user_name, :string
  end
end
