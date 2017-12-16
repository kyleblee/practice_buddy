class BackingTrack < ApplicationRecord
  has_many :tonalities, through: :backing_track_tonalities
  has_many :licks, through: :backing_track_tonalities
  belongs_to :artist
  belongs_to :genre
  has_many :users, through: :backing_track_users
end
