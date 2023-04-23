class FriendshipRequestSerializer < ActiveModel::Serializer
  attributes :id, :pending, :created_at, :updated_at
  has_one :user
  has_one :friend
end
