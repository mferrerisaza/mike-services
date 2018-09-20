class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user

  private

  def set_user
    cookies[:username] = 'guest'
    cookies[:username] = current_user.email unless current_user.blank?
  end
end
