class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id

  validates :body, :user_id, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def find_event_group_member(event_commentable)
    user = self.user
    user.group_members.find_by_group_id(event_commentable.group.id)
  end
end
