class AddAuthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authenticity_token, :string, null: false
  end
end
