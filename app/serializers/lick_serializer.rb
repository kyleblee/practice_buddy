class LickSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :tonalities, through: :lick_tonalities
end
