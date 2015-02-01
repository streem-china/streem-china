class AddBodyHtmlToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :body_html, :text
  end
end
