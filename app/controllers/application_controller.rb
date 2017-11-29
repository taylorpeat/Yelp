class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_user
    redirect_to log_in_path, notice: "You must be signed in." unless logged_in?
  end

  def current_user
    User.find(session[:user_id]) if logged_in?
  end

  def logged_in?
    session[:user_id]
  end


  helper_method :current_user, :logged_in? 
end
