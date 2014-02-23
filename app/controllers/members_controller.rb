class MembersController < ApplicationController
  def index

  end

  def show
    @member = User.find(params[:id]).group_members.find_by_group_id(params[:group_id])

    @group = Group.find(params[:group_id])

    @members = @group.members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)

    @comments = @member.comments
  end

  def comment
    @member = User.find(params[:id]).group_members.find_by_group_id(params[:group_id])
    @comment = @member.comments.new(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back
    else
      flash.now[:errors] = ["Must be logged in to post!"]
      redirect_to :back
    end
  end

end
