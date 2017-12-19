class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def index
    @licks = @user.licks
    # first, figure out what format you want the licks to be in
    # then, add the filter logic (which should be mostly handled in the model)
  end
end
