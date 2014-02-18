class AccountsController < ApplicationController
  before_filter :require_current_user

  def show
    @user = current_user
  end
end
