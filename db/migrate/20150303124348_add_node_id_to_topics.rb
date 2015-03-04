class AddNodeIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :node_id, :integer, default: 1
  end
end
