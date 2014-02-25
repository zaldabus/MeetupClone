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
        @events[event.date] << event
      end

    else
      @groups = Group.all
    end
  end

  def find
    if params[:query]
      @results = PgSearch.multisearch(params[:query])
    else
      @results = PgSearch::Document
    end

    @results = @results.includes(:searchable)
  end
end