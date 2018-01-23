class LickSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :last_practiced, :scheduled_practice, :bpm, :current_key, :performance_rating, :description
  has_many :tonalities, through: :lick_tonalities
  has_many :backing_tracks, through: :backing_track_licks
end
