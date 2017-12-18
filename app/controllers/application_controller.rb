class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to users_sign_in_url if !logged_in?
  end

  def authenticate_owner
    # Add logic here for checking whether the user is logged in and is the
    # owner of the content they are trying to access.
  end

  def not_logged_in?
    redirect_to home_url if logged_in?
  end
end
