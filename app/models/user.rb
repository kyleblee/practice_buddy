class User < ApplicationRecord
  belongs_to :location, optional: true
  has_many :licks
  has_many :tunes
  has_many :artists, through: :artist_users
  has_many :backing_tracks, through: :backing_track_users

  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates_email_format_of :email, message: "Please enter a valid email address."

  validates :name, presence: true
end
