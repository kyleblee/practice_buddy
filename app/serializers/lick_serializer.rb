class LickSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :last_practiced, :scheduled_practice
  has_many :tonalities, through: :lick_tonalities
end
