class EventsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
    # @address = @event.addresses.new
  end

  def create
    @group = Group.find(params[:group_id])

    @event = Event.new(params[:event])
    @event.group_id = params[:group_id]
    @event.addresses.new(params[:address])

    # Put in extra code to check for events on same day but later time
    if check_time(params[:event][:date], params[:event][:time]) < Time.now

      flash.now[:errors] = ["Event must be later than now!"]
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

    @members = @group.members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end

  def event_signup
    @group = Group.find(params[:group_id])

    if @group.members.include?(current_user)
      @event_signup = EventSignup.new(
                    event_id: params[:id],
                    attendee_id: current_user.id
                    )
    else
      flash[:errors] = ["Must be a member to join event!"]
      redirect_to group_event_url(params[:group_id], params[:id])
    end

    if @event_signup.save
      redirect_to group_event_url(params[:group_id], params[:id])
    else
      flash[:errors] = ["Already signed up for event!"]
      redirect_to group_event_url(params[:group_id], params[:id])
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
