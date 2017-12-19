class BackingTrack < ApplicationRecord
  has_many :backing_track_tonalities
  has_many :backing_track_licks
  has_many :backing_track_users
  has_many :tonalities, through: :backing_track_tonalities
  has_many :licks, through: :backing_track_licks
  has_many :users, through: :backing_track_users
  belongs_to :artist
  belongs_to :genre
end
