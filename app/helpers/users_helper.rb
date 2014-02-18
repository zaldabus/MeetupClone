module UsersHelper
  def photo_change(user)
    user.avatar.url == "/images/noPhoto_80.png" ? link_to("Add your photo", edit_account_url) : link_to("Change your photo", edit_account_url)
  end
end
