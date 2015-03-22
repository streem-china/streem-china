class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end
