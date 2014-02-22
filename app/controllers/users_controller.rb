class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.addresses.new(params[:address])

    if @user.save
      login(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.limit(10)
    @comments = @user.comments
    @interests = @user.interests
  end

  def comment
    @user = User.find(params[:id])
    @comment = @user.comments.new(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back
    else
      flash.now[:errors] = ["Must be logged in to post!"]
      redirect_to :back
    end
  end

end