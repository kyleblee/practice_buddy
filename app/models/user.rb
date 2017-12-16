class User < ApplicationRecord
  belongs_to :location
  has_many :licks
  has_many :tunes
  has_many :artists, through: :artist_users
  has_many :backing_tracks, through: :backing_track_users
  has_secure_password
end
