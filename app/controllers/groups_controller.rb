class GroupsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
  end

  def show
    @group = Group.find(params[:id])
  end
end
