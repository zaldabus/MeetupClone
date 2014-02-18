class RemoveOwnerIndex < ActiveRecord::Migration
  def change
    remove_index :groups, :owner_id
  end
end
