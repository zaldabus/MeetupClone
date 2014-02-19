class GroupsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
  end

  def show
    # Seems verbose and makes a lot of calls to database
    # Can we optimize it?

    @group = Group.find(params[:id])
    @members = @group.members
    @member_short_list = @members.limit(10)
    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end
end
