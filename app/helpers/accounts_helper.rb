module AccountsHelper
  def birthday(user)
    user.birthday ? user.birthday : link_to("set birthday", edit_account_url)
  end

  def check_notification(notification)
    if notification.notificationable_type == "Group"
      group = Group.find(notification.notificationable_id)
      link_to("#{group.title} wants you to join their group!", join_group_url(group))
    end
  end

  def group_notification(notification)
    group = Group.find(notification.notificationable_id)
    link_to("#{group.title} wants you to join their group!", notification_url(notification))
  end
end
