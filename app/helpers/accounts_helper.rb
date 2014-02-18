module AccountsHelper
  def city(user)
    user.addresses.first.city
  end

  def state(user)
    user.addresses.first.state
  end

  def birthday(user)
    user.birthday ? user.birthday : link_to("set birthday", edit_account_url)
  end
end
