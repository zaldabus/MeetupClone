module ApplicationHelper
  def current_user
    return nil unless session[:token]

    @current_user ||= User.find_by_authenticity_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:token] = user.authenticity_token
  end

  def logout(user)
    current_user.reset_authenticity_token! if logged_in?
    session[:token] = nil
  end

  def require_current_user
    redirect_to root_url unless logged_in?
  end

  def city_state(object)
    "#{object.addresses.first.city}, #{object.addresses.first.state}"
  end
end
