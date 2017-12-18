class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def index
    @licks = @user.licks
  end
end
