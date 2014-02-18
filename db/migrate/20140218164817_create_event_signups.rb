class CreateEventSignups < ActiveRecord::Migration
  def change
    create_table :event_signups do |t|
      t.integer :attendee_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end

    add_index :event_signups, [:attendee_id, :event_id], unique: true
  end
end
