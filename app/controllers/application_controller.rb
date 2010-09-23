class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  private
    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= (current_user_session && current_user_session.record)
    end
end
