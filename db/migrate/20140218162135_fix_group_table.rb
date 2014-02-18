class FixGroupTable < ActiveRecord::Migration
  def change
    drop_table :groups
    create_table :groups do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :owner_id, null: false

      t.timestamps
    end

    add_index :groups, :owner_id, unique: true
  end
end
