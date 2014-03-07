module GroupsHelper

  def time_since(date)
    time = (Time.now - date).to_i

    check_times(time)
  end

  def time_units
    {
      months_from_day: [:day, :month, 30],
      days_from_hours: [:hour, :day, 24],
      hours_from_minutes: [:minute, :hour, 60],
      minutes_from_seconds: [:second, :minute, 60],
      seconds_from_seconds: [:second, :second, 1]
    }
  end

  def check_times(time)
    time_units.each do |_, time_unit|
      if time / 1.send(time_unit[0]) > time_unit[2]
        time /= 1.send(time_unit[1])
        units = time_unit[1].to_s.pluralize(time)

        return "#{time} #{units} ago"
      end
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
          </a>commented on <a
          href='#{group_event_url(activity.commentable.group, activity.commentable)}'
          >#{activity.commentable.title}</a>".html_safe
    end
  end
end