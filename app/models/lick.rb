class Lick < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  has_many :tonalities, through: :lick_tonalities
  has_many :backing_tracks, through: :backing_track_tonalities
  has_many :genres, through: :genre_licks
end
