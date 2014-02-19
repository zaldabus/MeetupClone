class AddLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string, null: false
  end
end
