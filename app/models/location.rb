class Location < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :name, uniqueness: { message: "That location has already been created." }
end
