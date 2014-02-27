module ApplicationHelper
  require 'addressable/uri'

  def new_user
    @user ||= User.new
  end

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

  def full_address(object)
    "#{object.addresses.first.address_line}, #{object.addresses.first.city}, #{object.addresses.first.state}"
  end

  def photo_change(user)
    user.avatar.url == "/assets/noPhoto_80.png" ? link_to("Add a photo", edit_account_url) : link_to("Change your photo", edit_account_url)
  end

  def google_map(object)
    Addressable::URI.new(
      :scheme => "http",
      :host => "maps.google.com",
      :path => "maps",
      :query_values => { "q" => "#{object.addresses.first.address_line} " +
                                 "#{object.addresses.first.city} " +
                                 "#{object.addresses.first.state} " +
                                 "#{object.addresses.first.zip_code}"
                                 }
    ).to_s
  end

end
