class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible :user_id, :event_type

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
    when "Event"
      event = Event.find(self.notificationable_id)
      group_event_path(event.group, event)
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
    when "Event"
      self.event_match
    end
  end

  def event_match
    event_reference = self.event_type
    case event_reference

    when "New Attendee"
      event = Event.find(self.notificationable_id).title
      "Another member has joined #{event}!"
    when "New Comment"
      event = Event.find(self.notificationable_id).title
      "Another member commented on #{event}"
    end
  end
end