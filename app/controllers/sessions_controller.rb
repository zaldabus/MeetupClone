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
      flash[:errors] = ["Email or Password is Incorrect!"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_url
  end
end
