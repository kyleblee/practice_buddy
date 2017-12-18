class UsersController < ApplicationController
  before_action :not_logged_in?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if auth
      # Omniauth signup / login
      @user = User.find_or_create_by(uid: auth[:uid]) do |u|
        u.name = auth[:info][:name]
        u.email = auth[:info][:email]
        u.image = auth[:info][:image]
        u.password = SecureRandom.hex(9)
      end
      session[:user_id] = @user.id
      redirect_to home_url
    else
      # Signup through the form
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to home_path
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def auth
    request.env['omniauth.auth']
  end
end
