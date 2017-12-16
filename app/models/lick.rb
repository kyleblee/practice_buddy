class Lick < ApplicationRecord
  belongs_to :user
  belongs_to :artist, optional: true
  has_many :tonalities, through: :lick_tonalities
  has_many :backing_tracks, through: :backing_track_tonalities
  has_many :genres, through: :genre_licks

  validates :name, presence: true
  validates :performance_rating, :inclusion => { :in => 1..5 }, allow_nil: true
end
