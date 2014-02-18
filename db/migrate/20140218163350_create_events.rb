class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.datetime :date, null: false
      t.datetime :time, null: false
      t.integer :group_id, null: false

      t.timestamps
    end

    add_index :events, :group_id
  end
end
