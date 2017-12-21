class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :owner?

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to users_sign_in_url if !logged_in?
  end

  def authenticate_owner!
    unless logged_in? && current_user == User.find_by(id: params[:user_id])
      redirect_to home_path
    end
  end

  def not_logged_in?
    redirect_to home_url if logged_in?
  end

  def set_user
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
    else
      @user = User.find_by(id: params[:id])
    end
  end

  def owner?(object)
    current_user == object.user
  end
end
