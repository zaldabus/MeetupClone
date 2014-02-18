class Group < ActiveRecord::Base
  attr_accessible :title, :description, :owner_id

  validates :title, :description, :owner_id, presence: true
  validates :title, uniqueness: true

  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_many :group_memberships,
           class_name: "GroupMembership",
           foreign_key: :group_id

  has_many :users, through: :group_memberships
  has_many :events

  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar, styles: {
    big: "600x600>",
    small: "50x50>"
  }

end
