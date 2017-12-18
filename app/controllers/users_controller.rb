class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :not_logged_in?, only: [:new, :create]
  before_action :authenticate_owner!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    if auth
      # Omniauth signup / login
      @user = User.find_or_create_with_oauth(auth)
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

  def show
    if @user
      render :show
    else
      render :not_found
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :description, :set_location)
  end

  def auth
    request.env['omniauth.auth']
  end
end
