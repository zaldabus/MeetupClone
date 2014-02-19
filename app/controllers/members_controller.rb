class MembersController < ApplicationController
  def index

  end

  def show
    @member = User.find(params[:id])

    @group = Group.find(params[:group_id])

    @members = @group.members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end
end
