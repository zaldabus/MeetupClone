class EventsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
    @address = @event.addresses.new
  end

  def create
    @event = Event.new(params[:event])
    @event.group_id = params[:group_id]
    @event.addresses.new(params[:address])

    # Put in extra code to check for events on same day but later time
    if Time.new(params[:event][:date]) < Time.now
      flash.now[:errors] = ["Event must be after today!"]
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
    fail
    @event_signup = EventSignup.new(
                  event_id: params[:id],
                  attendee_id: current_user
                  )

    if @event_signup.save
      redirect_to group_event_url(params[:group_id], params[:event_id])
    else
      flash[:errors] = ["Already signed up for event!"]
      redirect_to group_event_url(params[:group_id], params[:event_id])
    end
  end
end
