class BackingTrack < ApplicationRecord
  has_many :backing_track_tonalities
  has_many :backing_track_licks
  has_many :backing_track_users
  has_many :tonalities, through: :backing_track_tonalities
  has_many :licks, through: :backing_track_licks
  has_many :users, through: :backing_track_users
  belongs_to :artist, optional: true
  belongs_to :genre, optional: true

  validates :name, presence: true
  validates :link, presence: true
end
