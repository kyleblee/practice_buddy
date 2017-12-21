class BackingTracksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]
  before_action :authenticate_owner!, only: [:update, :edit, :delete]
  before_action :set_backing_track_user, only: [:show]
  before_action :set_backing_track, only: [:show]

  def new
    @backing_track = BackingTrack.new
  end

  def show

  end

  private

  def set_backing_track
    @backing_track = BackingTrack.find_by(id: params[:id])
    if @backing_track.nil?
      flash[:message] = "Hmm, we can't seem to find that backing track."
      redirect_to backing_tracks_url
    end
  end

  def set_backing_track_user
    @user = User.find_by(id: params[:user_id]) if params[:user_id]
  end
end
