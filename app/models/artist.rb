class Artist < ApplicationRecord
  has_many :licks
  has_many :tunes
  has_many :genres, through: :artist_genres
  has_many :backing_tracks
  has_many :users, through: :artist_users
end
