class WelcomeController < ApplicationController

  def index
    if logged_in?
      redirect_to home_path
    end
  end
end
