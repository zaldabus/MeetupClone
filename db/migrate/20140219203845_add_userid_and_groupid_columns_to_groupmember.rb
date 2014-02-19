class AddUseridAndGroupidColumnsToGroupmember < ActiveRecord::Migration
  def change
    add_column :group_members, :user_id, :integer, null: false
  end
end
