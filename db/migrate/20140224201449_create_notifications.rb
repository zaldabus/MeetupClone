class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notificationable_id, null: false
      t.string :notificationable_type, null: false

      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :notifications, :user_id
  end
end
