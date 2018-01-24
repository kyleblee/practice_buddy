class NoteSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :lick_id, :created_at
  belongs_to :user
end
