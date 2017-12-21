class BackingTrack < ApplicationRecord
  has_many :backing_track_tonalities
  has_many :backing_track_licks
  has_many :backing_track_users
  has_many :tonalities, through: :backing_track_tonalities
  has_many :licks, through: :backing_track_licks
  belongs_to :user, optional: true
  belongs_to :artist, optional: true
  belongs_to :genre, optional: true

  validates :name, presence: true
  validates :link, presence: true

  before_validation :nil_if_blank

  include CustomSetters::InstanceMethods

  NULL_ATTRS = %w( name bpm key description link )

  def nil_if_blank
    NULL_ATTRS.each {|attr| self[attr] = nil if self[attr].blank?}
  end
end
