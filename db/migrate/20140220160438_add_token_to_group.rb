class AddTokenToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :group_token, :string, null: false
  end
end
