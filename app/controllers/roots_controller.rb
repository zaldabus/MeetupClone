class RootsController < ApplicationController
  def index
    if logged_in?
      events = []
      groups = current_user.groups.includes(:events).where("events.date BETWEEN ? AND ?", (Time.now - 1.year), (Time.now + 1.year) )

      groups.each do |group|
        events.concat(group.events)
      end

      @events = Hash.new { |hash, key| hash[key] = []}
      events.each do |event|
        @events[event.date.strftime("%Y-%m-%d")] << event
      end
    else
      @groups = Group.page(params[:page]).per(10)
    end

    if request.xhr?
      if @events[params[:date]]
        render partial: 'one_date', locals: {
                                      events: @events[params[:date]],
                                      date: params[:date]
                                    }
      else
        flash[:error] = "No events for selected day"
      end
    end
  end

  def find
    if params[:query]
      @results = PgSearch.multisearch(params[:query])
    else
      return @groups = Group.page(params[:page]).per(10)
    end

    @results = @results.includes(:searchable).page(params[:page]).per(10)
  end
end