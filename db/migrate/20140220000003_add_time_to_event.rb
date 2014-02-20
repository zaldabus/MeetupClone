class AddTimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :time, :time, null: false
  end
end
