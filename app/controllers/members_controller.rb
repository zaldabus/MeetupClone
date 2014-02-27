class MembersController < ApplicationController
  def index
    @group = Group.find(params[:group_id])

    @members = @group.group_members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)
  end

  def show
    @member = GroupMember.find(params[:id])

    @group = Group.find(params[:group_id])

    @members = @group.group_members

    @upcoming_events = @group.events.where(date: Time.now..Time.now + 1.year)
    @past_events = @group.events.where(date: Time.now - 1.year..Time.now)

    @comments = @member.comments
  end

  def comment
    @member = GroupMember.find(params[:id])
    @comment = @member.comments.new(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      if request.xhr?
        render partial: "roots/comment", locals: { comment: @comment }
      else
        redirect_to :back
      end
    else
      flash.now[:errors] = ["Must be logged in to post!"]
      redirect_to :back
    end
  end

end