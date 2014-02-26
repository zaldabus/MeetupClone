module GroupsHelper
  def time_since(date)
    if (Time.now - date).to_i / 1.day > 30
      time = (Time.now - date).to_i / 1.month
      months = "month".pluralize(time)

      "#{time} #{months} ago"
    elsif (Time.now - date).to_i / 1.hour > 24
      time = (Time.now - time).to_i / 1.day
      days = "day".pluralize(time)

      "#{time} #{days} ago"
    elsif (Time.now - date).to_i / 1.minute > 60
      time = (Time.now - date).to_i / 1.hour
      hours = "hour".pluralize(time)

      "#{time} #{hours} ago"
    else
      time = (Time.now - date).to_i / 1.minute
      hours = "minute".pluralize(time)

      "#{time} #{hours} ago"
    end
  end

  def type(activity)
    case activity

    when GroupMember
      "<i class='icon-user'></i><span>NEW MEMBER</span>".html_safe
    when EventSignup
      "<i class='icon-ok'></i><span>NEW RSVP</span>".html_safe
    when Comment
      "<i class='icon-comment'></i><span>NEW COMMENT</span>".html_safe
    end
  end

  def message(activity)
    case activity

    when GroupMember
      "<a href='#{group_member_url(activity.group, activity)}'
          >#{activity.name}</a> Joined".html_safe
    when EventSignup
      "<a href='#{group_member_url(activity.attendee.group, activity.attendee)}'
          >#{activity.attendee.name}
          </a>RSVPed for <a
              href='#{group_event_url(activity.event.group, activity.event)}'
              >#{activity.event.title}</a>".html_safe
    when Comment
      "<a href='#{group_member_url(activity.commentable.group, activity.find_event_group_member(activity.commentable))}'
          >#{activity.find_event_group_member(activity.commentable).name}
          </a>commented on<a
          href='#{group_event_url(activity.commentable.group, activity.commentable)}'
          >#{activity.commentable.title}</a>".html_safe
    end
  end
end