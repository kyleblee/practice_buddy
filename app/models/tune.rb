class Tune < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :artist, optional: true
  belongs_to :user

  validates :name, presence: true
  validates :performance_rating, :inclusion => { :in => 1..5 }, allow_nil: true
end
