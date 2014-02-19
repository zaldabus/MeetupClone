class AddAvatarToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :groups, :avatar
  end
end
