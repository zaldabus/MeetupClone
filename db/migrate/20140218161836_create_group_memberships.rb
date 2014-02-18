class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :member_id, null: false
      t.integer :group_id, null: false

      t.timestamps
    end

    add_index :group_memberships, [:member_id, :group_id], unique: true
  end
end
