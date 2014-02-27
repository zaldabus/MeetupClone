class AccountsController < ApplicationController
  before_filter :require_current_user

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to account_url
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def notifications
    @notifications = current_user.notifications
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user

    if @user.has_password?(params[:user][:password])

      if params[:user][:new_password] == params[:user][:password_confirmation]
        @user.password = params[:user][:new_password]
        flash[:notice] = "Password Updated!"
        redirect_to account_url
      else
        flash.now[:errors] = "Please make sure new password and confirmation match!"
        render :change_password
      end
    else
      flash.now[:errors] = "Old Password Incorrect!"
      render :change_password
    end
  end

  def change_address
    @address = current_user.address
  end

  def update_address
    @address = current_user.address

    if @address.update_attributes(params[:address])
      flash[:notice] = "Address Updated!"
      redirect_to account_url
    else
      flash.now[:errors] = "An Error Occurred!"
      render :change_address
    end
  end
end
