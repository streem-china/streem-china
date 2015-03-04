class CreateNodes < ActiveRecord::Migration
  def up
    create_table :nodes do |t|
      t.string :name
      t.integer :topics_count, default: 0
    end

    Node.create(id: 1, name: 'NoPoint')
  end

  def down
    drop_table :nodes
  end
end
