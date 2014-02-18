class ChangeOwnerIdOfGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :user_id
    add_column :groups, :owner_id, :integer
  end
end
