class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :title, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :interests, :user_id
  end
end
