class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])

    @group = @event.group

    @members = @group.members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end

  def event_signup
    @event_signup = EventSignup.new (
                  event_id: params[:event_id]
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
