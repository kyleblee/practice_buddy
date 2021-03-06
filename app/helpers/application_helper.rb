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

  def submit_button(f, object)
    if object.id
      f.submit "Update #{object.class.name.underscore.humanize.titleize}"
    else
      f.submit "Create #{object.class.name.underscore.humanize.titleize}"
    end
  end

  def url_and_method(object, user)
    if object.id
      if object.class.name == "Lick"
        {url: user_lick_url(user, object), method: 'patch'}
      else
        {url: user_backing_track_url(user, object), method: 'patch'}
      end
    else
      if object.class.name == "Lick"
        {url: user_licks_url(user)}
      else
        {url: user_backing_tracks_url(user)}
      end
    end
  end
end
