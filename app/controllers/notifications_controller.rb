class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!
  def create
    @notification = Notification.new
    @notification.endpoint = params[:endpoint]
    @notification.p256dh = params[:keys][:p256dh]
    @notification.auth = params[:keys][:auth]
    @notification.save
  end
end
