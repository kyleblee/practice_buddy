class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def index
    @user = current_user
    @licks = @user.licks
    # Need to add logic that accomodates if filters / sorts have been selected.
    # They are reaching params correctly now.
  end
end
