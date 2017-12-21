module CustomSetters
  module InstanceMethods
    def new_artist=(artist_attr)
      if artist_attr[:name].blank?
        self.artist_id ||= nil
      else
        artist = Artist.find_or_create_by(artist_attr)
        self.class.name == "Lick" ? artist.licks << self : artist.backing_tracks << self
      end
    end
  end
end
