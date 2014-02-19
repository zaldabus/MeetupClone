class GroupMembership < ActiveRecord::Base
  attr_accessible :member_id, :group_id

  validates :member_id, :group_id, presence: true
  validates :member_id, uniqueness: { scope: :group_id }

  belongs_to :member, class_name: "User", foreign_key: :member_id
  belongs_to :group, class_name: "Group", foreign_key: :group_id
end
