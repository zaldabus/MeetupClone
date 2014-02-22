class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id

  validates :body, :user_id, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
