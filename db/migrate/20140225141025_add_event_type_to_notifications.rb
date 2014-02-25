class AddEventTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :event_type, :string
  end
end
