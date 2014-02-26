class GroupsController < ApplicationController
  before_filter :require_current_user, only: [:new, :create, :join]

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
  end

  def new
    @group = Group.new
    @address = @group.addresses.new
    @invitees = User.all
  end

  def create
    @group = Group.new(params[:group])
    @group.owner_id = current_user.id
    @group.addresses.new(params[:address])

    @invitees = User.all

    if @group.save
      flash[:notice] = "New Meetup Group Created!"

      GroupMember.create(name: current_user.name, email: current_user.email, user_id: current_user.id, group_id: @group.id)

      #Sends out invite to each user who was checked on form
      params[:invitees].each do |id|
        next if id == ""
        @user = User.find(id)
        @group.notifications.create(user_id: @user.id)
        GroupMailer.invite_email(@user, @group)

        # Requires worker to be turned on
        # GroupMailer.delay(run_at: 10.seconds.from_now).invite_email(@user, @group)
      end

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

    @members = @group.group_members
    @member_short_list = @members.limit(10)

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @upcoming_short_list = @upcoming_events.limit(2)

    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
    @past_short_list = @past_events.limit(2)

    @recent_activity = @group.recent_activity
  end

  def join
    @group_member = GroupMember.new(
                          user_id: current_user.id,
                          group_id: params[:id],
                          name: current_user.name,
                          email: current_user.email
                          )

    if @group_member.save
      @group = Group.find(params[:id])

      @group.group_members.each do |member|
        next if member.user = current_user
        @group_member.notifications.create(user_id: member.user.id)
      end

      redirect_to group_url(params[:id])
    else
      flash[:errors] = "Already a member of this group!"
      redirect_to group_url(params[:id])
    end
  end

  def email_join
    @user = User.find(params[:user_id])
    @group = Group.find_by_group_token(params[:group_token])

    if @user && @group
      GroupMember.create(
        name: @user.name,
        email: @user.email,
        user_id: @user.id,
        group_id: @group.id
        )

        @group.group_members.each do |member|
          next if member.user = @user
          @group_member.notifications.create(user_id: member.user.id)
        end

        redirect_to group_url(@group)
    else
      flash[:errors] = "User or Group not found!"
      redirect_to root_url
    end
  end

end
