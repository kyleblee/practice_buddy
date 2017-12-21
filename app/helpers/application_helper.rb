module ApplicationHelper

  def format_date_for_show(date)
    if date
      date.strftime("%b %e, %Y")
    else
      "no date is currently set"
    end
  end

  def artist_name(lick_or_backing_track)
    " - #{lick_or_backing_track.artist.name}" if lick_or_backing_track.artist
  end
end
