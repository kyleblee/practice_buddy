class User < ApplicationRecord
  belongs_to :location, optional: true
  has_many :licks
  has_many :tunes
  has_many :artist_users
  has_many :backing_track_users
  has_many :artists, through: :artist_users
  has_many :backing_tracks

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

  def lick_count
    self.licks.count
  end

  def tune_count
    self.tunes.count
  end

  def wanted_attr_for_list(key, value)
    key == "email" || key == "description" || key == "location_id"
  end

  def self.new_with_email_error
    self.new do |u|
      u.errors.add(:email, :not_found, message: "not found in existing users.")
    end
  end

  def password_error
    self.errors.add(:password, :incorrect, message: "is incorrect for the email provided.")
  end

  def set_location=(location)
    if location.blank?
      Location.find_by(name: self.location_name).users.delete(self)
      self.update(location: nil)
    else
      loc = Location.find_or_create_by(name: location)
      loc.users << self
    end
  end

  def location_name
    self.location.try(:name)
  end

  def self.owner?(current_user, params)
    if params[:user_id]
      current_user == User.find_by(id: params[:user_id])
    else
      current_user == User.find_by(id: params[:id])
    end
  end
end
