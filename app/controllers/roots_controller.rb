class RootsController < ApplicationController
  def index
    if logged_in?
      events = []
      groups = current_user.groups.includes(:events).where("events.date BETWEEN ? AND ?", Time.now, (Time.now + 1.year) )
      groups.each do |group|
        events.concat(group.events)
      end
      @events = events.sort_by &:date
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
    # @groups = Group.all
  end
end