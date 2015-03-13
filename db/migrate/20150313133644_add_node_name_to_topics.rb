class AddNodeNameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :node_name, :string
  end
end
