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

  def self.find_or_create_with_oauth(auth)
    User.find_or_create_by(uid: auth[:uid]) do |u|
      u.name = auth[:info][:name]
      u.email = auth[:info][:email]
      u.image = auth[:info][:image]
      u.password = SecureRandom.hex(9) # in order to persist to the database, through has_secure_password
    end
  end
end
