class NotificationsController < ApplicationController
  def show
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_to notification.url
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_to notifications_account_url
  end
end
