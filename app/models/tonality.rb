class Tonality < ApplicationRecord
  has_many :lick_tonalities
  has_many :backing_track_tonalities
  has_many :licks, through: :lick_tonalities
  has_many :backing_tracks, through: :backing_track_tonalities

  validates :name, presence: true
  validates :name, uniqueness: { message: "That tonality has already been created." }
end
