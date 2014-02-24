class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :user_id

  validates :user_id, presence: true

  belongs_to :user
  belongs_to :notificationable, polymorphic: true

  def url
    type = self.notificationable_type
    case type

    when "Group"
      group_path(self.notificationable_id)
    when "GroupMember"
      group_member = GroupMember.find(self.notificationable_id)
      group_member_path(group_member.group, group_member)
    end
  end

  def message
    type = self.notificationable_type
    case type

    when "Group"
      group = Group.find(self.notificationable_id).title
      "#{group} wants you to join their group!"
    when "GroupMember"
      group = GroupMember.find(self.notificationable_id).group.title
      "#{group} has a new member!"
    end
  end
end