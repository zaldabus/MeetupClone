class Notification < ActiveRecord::Base
  attr_accessible :user_id

  validates :user_id, presence: true

  belongs_to :user
  belongs_to :notificationable, polymorphic: true

end