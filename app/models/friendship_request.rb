class FriendshipRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, :user_id, :friend, :friend_id, presence: true
  validates :user_id, uniqueness: { scope: :friend_id }

  def accept
    Friendship.create(user: user, friend: friend)
    Friendship.create(user: friend, friend: user)
    destroy
  end

end
