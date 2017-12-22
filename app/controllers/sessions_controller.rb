class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :not_logged_in?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = User.find_by(email: session_params[:email])
      if @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to home_url
      else
        @user.password_error
        render :new
      end
    else
      @user = User.new_with_email_error
      render :new
    end
  end

  def index
    @user = current_user
    @licks_of_the_day = Lick.licks_of_the_day(@user)
    @overdue = Lick.overdue_licks(@user)
    @sloppiest = Lick.sloppiest_licks(@user)
    @newest_bt = BackingTrack.newest_backing_tracks
  end

  def destroy
    if logged_in?
      session.delete :user_id
      flash[:message] = "You have successfully logged out."
    end
    redirect_to users_sign_in_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
