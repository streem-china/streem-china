class AddBodyHtmlToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :body_html, :text
  end
end
