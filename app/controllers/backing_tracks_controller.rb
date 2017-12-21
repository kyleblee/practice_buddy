class BackingTracksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]
  before_action :authenticate_owner!, only: [:update, :edit, :delete]
  before_action :set_backing_track_user, only: [:show, :new, :create]
  before_action :set_backing_track, only: [:show]

  def new
    @backing_track = BackingTrack.new
  end

  def show

  end

  def create
    @backing_track = @user.backing_tracks.create(backing_track_params)
    if @backing_track.valid?
      redirect_to user_backing_track_url(@user, @backing_track)
    else
      render :new
    end
  end

  private

  def backing_track_params
    params.require(:backing_track).permit(:name, :bpm, :key, :link, :description,
      :last_practiced, :artist_id, {new_artist: [:name]})
  end

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
