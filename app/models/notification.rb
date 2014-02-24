class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :user_id

  validates :user_id, presence: true

  belongs_to :user
  belongs_to :notificationable, polymorphic: true

  def url
    if self.notificationable_type == "Group"
      group_path(self.notificationable_id)
    end
  end

end