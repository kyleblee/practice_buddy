module BackingTracksHelper

  def backing_track_header(backing_tracks)
    if params[:user_id].to_i == current_user.try(:id)
      "My Backing Tracks"
    elsif owner = User.find_by(id: params[:user_id])
      "#{owner.name}'s Backing Tracks"
    else
      "Backing Tracks"
    end
  end

  def back_to_backing_tracks(backing_track)
    if backing_track.user
      if owner?(backing_track)
        button_to "<< My backing tracks", user_backing_tracks_path(backing_track.user), method: 'get'
      else
        button_to "<< #{backing_track.user.name}'s backing tracks", user_backing_tracks_path(backing_track.user), method: 'get'
      end
    end
  end


  def my_backing_tracks_button(params)
    unless params[:user_id] && params[:user_id].to_i == current_user.id
      button_to "My Backing Tracks", user_backing_tracks_path(current_user), method: 'get'
    end
  end
end
