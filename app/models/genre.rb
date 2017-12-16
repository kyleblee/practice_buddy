class Genre < ApplicationRecord
  has_many :artists, through: :artist_genres
  has_many :tunes
  has_many :licks, through: :genre_licks
  has_many :backing_tracks
end
