class GroupMailer < ActionMailer::Base
  default from: "DumbMeetupGroups@dumbmeetup.com"

  def invite_email(user, group)
    @user = user
    @group = group
    @url = email_join_user_groups_url(@user, group_token: @group.group_token)
    mail(to: user.email, subject: "You got a group invite!")
  end
end
