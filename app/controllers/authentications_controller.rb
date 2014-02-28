class AuthenticationsController < ApplicationController
  # Will implement this action later
  def index
    @authentications = current_user.authentications if logged_in?
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(
                                              omniauth['provider'],
                                              omniauth['uid'])

    if authentication
      flash[:notice] = "Signed in successfully."
      login(authentication.user)
      redirect_to root_url
    elsif current_user
      current_user.authentications.create!(
                            :provider => omniauth['provider'],
                            :uid => omniauth['uid'])

      flash[:notice] = "Authentication successful"
      redirect_to root_url
    else
      @user = User.new
      session[:omniauth] = omniauth.except('extra')
      flash[:notice] = "Authentication added!"
      redirect_to new_user_url
    end
  end

  # Will implement this action later
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
