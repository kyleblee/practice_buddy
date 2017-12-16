class Tune < ApplicationRecord
  belongs_to :genre
  belongs_to :artist
  belongs_to :user
end
