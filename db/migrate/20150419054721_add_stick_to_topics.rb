class AddStickToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :stick, :boolean, default: false
  end
end
