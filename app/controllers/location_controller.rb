class LocationController < ApplicationController

  def index
    @locations = Location.all
  end
end
