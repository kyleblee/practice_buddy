class Note < ApplicationRecord
  belongs_to :user
  belongs_to :lick

  validates :content, presence: true

  before_validation :nil_if_blank

  NULL_ATTRS = %w( content )

  def nil_if_blank
    NULL_ATTRS.each {|attr| self[attr] = nil if self[attr].blank?}
  end
end
