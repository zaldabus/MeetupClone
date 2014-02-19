class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])

    @group = @event.group

    @members = @group.members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end
end
