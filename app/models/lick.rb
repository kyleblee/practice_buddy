class Lick < ApplicationRecord
  belongs_to :user
  belongs_to :artist, optional: true
  has_many :lick_tonalities
  has_many :backing_track_tonalities
  has_many :genre_licks
  has_many :tonalities, through: :lick_tonalities
  has_many :backing_tracks, through: :backing_track_tonalities
  has_many :genres, through: :genre_licks

  validates :name, presence: true
  validates :performance_rating, :inclusion => { :in => 1..5 }, allow_nil: true

  SORT_OPTIONS = [
    "Tonality",
    "Artist",
    "Date Last Practiced",
    "Scheduled Practice Date"
  ]

  def tonality_list(lick)
    unless lick.tonalities.empty?
      return_list = "("

      list = self.tonalities.enum_for(:each_with_index).collect do |t, i|
        i == 0 ? t.name : ", #{t.name}"
      end

      return_list << list.join + ")"
    end
    return_list
  end

  def self.grouped_options(user)
    tonalities = user.licks.collect do |l|
      l.tonalities.collect do |t|
        t.name
      end
    end
    artists = user.licks.reject{|l| l.artist.try(:name) == nil}.collect do |l|
      l.artist.name
    end
    options = [
      ["Tonalities", tonalities.flatten],
      ["Artists", artists]
    ]
  end
end
