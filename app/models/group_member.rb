class GroupMember < ActiveRecord::Base
  attr_accessible :name, :email, :user_id, :group_id

  validates :name, :email, :user_id, :group_id, presence: true

  belongs_to :user

  has_many :comments, as: :commentable

  def addresses
    self.user.addresses
  end

  def interests
    self.user.interests
  end

  def avatar_url
    self.user.avatar.url
  end

  def groups
    self.user.groups
  end

end
