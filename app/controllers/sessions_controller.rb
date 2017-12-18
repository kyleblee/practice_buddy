class SessionsController < ApplicationController
  def new

  end

  def index

  end

  def destroy
    if logged_in?
      session.delete :user_id
      flash[:message] = "You have successfully logged out."
    end
    redirect_to users_sign_in_url
  end
end
