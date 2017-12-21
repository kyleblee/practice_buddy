module BackingTracksHelper

  def backing_track_header(backing_tracks)
    if params[:user_id].to_i == current_user.id
      "My Backing Tracks"
    elsif owner = User.find_by(id: params[:user_id])
      "#{owner.name}'s Backing Tracks"
    else
      "Backing Tracks"
    end
  end
end
