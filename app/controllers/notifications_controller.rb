class NotificationsController < ApplicationController
  def destroy
    notification = Notification.find(params[:id])
    notification.delete
    redirect_to notifications_account_url
  end
end
