class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user, :signed_in?

  private
    def signed_in?
      !current_user_session.nil?
    end

    def admin_user?
      signed_in? and current_user.admin?
    end

    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= (current_user_session && current_user_session.record)
    end

    def ensure_signed_in
      unless current_user
        store_location
        flash[:notice] = 'You must be signed in to access this page'
        redirect_to signin_path
        return false
      end
    end

    def ensure_admin_user
      unless admin_user?
        redirect_to doctors_path
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
