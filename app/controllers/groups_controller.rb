class GroupsController < ApplicationController
  before_filter :require_current_user, only: [:new, :create, :join]

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
  end

  def new
    @group = Group.new
    @address = @group.addresses.new
  end

  def create
    @group = Group.new(params[:group])
    @group.owner_id = current_user.id
    @group.addresses.new(params[:address])

    if @group.save
      flash[:notice] = "New Meetup Group Created!"
      GroupMembership.create(member_id: current_user.id, group_id: @group.id)
      redirect_to group_url(@group)
    else
      flash.now[:errors] = @group.errors.full_messages
      render :new
    end
  end

  def show
    # Seems verbose and makes a lot of calls to database
    # Can we optimize it?

    @group = Group.find(params[:id])

    @members = @group.members
    @member_short_list = @members.limit(10)

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @upcoming_short_list = @upcoming_events.limit(2)

    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
    @past_short_list = @past_events.limit(2)
  end

  def join
    @group_membership = GroupMembership.new(
                          member_id: current_user,
                          group_id: params[:id]
                          )

    if @group_membership.save
      GroupMember.create(
        name: current_user.name,
        email: current_user.email,
        user_id: current_user.id,
        group_id: params[:id]
        )

      redirect_to group_url(params[:id])
    else
      flash[:errors] = ["Already a member of this group!"]
      redirect_to group_url(params[:id])
    end
  end
end
