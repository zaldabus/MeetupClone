class EventsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end

  def create
    @group = Group.find(params[:group_id])

    @event = Event.new(params[:event])
    @event.group_id = params[:group_id]
    @event.addresses.new(params[:address])

    if check_time(params[:event][:date], params[:event][:time]) < Time.now

      flash.now[:errors] = "Event must be later than now!"
      render :new
    elsif @event.save
      flash[:notice] = "New Meetup Event Created!"
      EventSignup.create(attendee_id: current_user.id, event_id: @event.id)
      redirect_to group_event_url(params[:group_id], @event)
    else
      flash.now[:errors] = @event.errors.full_messages
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])

    @group = @event.group

    @members = @group.group_members

    if logged_in?
      @member = @members.find_by_user_id(current_user.id)
    end

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)

    @comments = @event.comments
  end

  def event_signup
    @group = Group.find(params[:group_id])
    @group_member = current_user.group_members.find_by_group_id(@group)

    if @group_member
      @event_signup = EventSignup.new(
                    event_id: params[:id],
                    attendee_id: @group_member.id
                    )
    else
      flash[:errors] = "Must be a member to join event!"
      redirect_to group_event_url(params[:group_id], params[:id])
    end

    if @event_signup.save
      @event_signup.event.attendees.each do |attendee|
        next if attendee.user == current_user
        @event_signup.event.notifications.create(user_id: attendee.user.id, event_type: "New Attendee")
      end

      redirect_to group_event_url(params[:group_id], params[:id])
    else
      flash[:errors] = "Already signed up for event!"
      redirect_to group_event_url(params[:group_id], params[:id])
    end
  end

  def comment
    @event = Event.find(params[:id])
    @comment = @event.comments.new(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      @event.attendees.each do |attendee|
        next if attendee.user == current_user
        @event.notifications.create(user_id: attendee.user.id, event_type: "New Comment")
      end

      if request.xhr?
        render partial: "roots/comment", locals: { comment: @comment }
      else
        redirect_to :back
      end
    else
      flash.now[:errors] = "Must be logged in to post!"
      redirect_to :back
    end
  end

  private
  def check_time(date, time)
    full_time = []

    date = date.split("-").map(&:to_i)
    time = time.split(":").map(&:to_i)
    full_time.concat(date).concat(time)

    DateTime.new(full_time[0], full_time[1], full_time[2], full_time[3], full_time[4])
  end
end
