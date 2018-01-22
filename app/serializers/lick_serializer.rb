class LickSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id
  has_many :tonalities, through: :lick_tonalities
end
