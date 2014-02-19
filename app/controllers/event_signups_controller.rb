class EventSignupsController < ApplicationController
  def create
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
