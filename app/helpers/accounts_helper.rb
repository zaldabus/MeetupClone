module AccountsHelper
  def birthday(user)
    user.birthday ? user.birthday.strftime("%B %d, %Y") : link_to("set birthday", edit_account_url)
  end
end
