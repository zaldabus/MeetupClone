class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
                  params[:user][:email],
                  params[:user][:password]
                  )

    if @user
      login(@user)
      redirect_to root_url
    else
      flash[:modal] = true
      redirect_to :back
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_url
  end
end
