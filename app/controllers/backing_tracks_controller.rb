class BackingTracksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]
  before_action :authenticate_owner!, only: [:update, :edit, :delete]
  before_action :set_user, only: [:show]
  before_action :set_backing_track, only: [:show]

  def show

  end

  private

  def set_backing_track
    @backing_track = BackingTrack.find_by(id: params[:id])
  end
end
