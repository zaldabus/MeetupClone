class AddGroupidColumnToGroupmember < ActiveRecord::Migration
  def change
    add_column :group_members, :group_id, :integer, null: false
  end
end
