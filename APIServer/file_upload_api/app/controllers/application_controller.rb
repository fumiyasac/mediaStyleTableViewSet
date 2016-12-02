class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ベーシック認証をかける
  if Rails.env == "production"
    BASIC_AUTH_USER_NAME     = ENV['BASIC_AUTH_USERNAME']
    BASIC_AUTH_USER_PASSWORD = ENV['BASIC_AUTH_PASSWORD']
  elsif Rails.env == "development"
    BASIC_AUTH_USER_NAME     = 'kanazawa_user'
    BASIC_AUTH_USER_PASSWORD = 'kanazawa_password'
  end
end
