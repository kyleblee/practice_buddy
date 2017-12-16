class BackingTrackUser < ApplicationRecord
  belongs_to :backing_track
  belongs_to :user
end
