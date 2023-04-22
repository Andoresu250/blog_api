class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :content, :post_type, :author_id, :author, presence: true
  validates :post_type, inclusion: { in: ['Public', 'Private', 'My Friends'] }

  scope :by_post_type, -> (type) { where( posts: {post_type: type} ) }

  scope :for_every_one, -> { by_post_type('Public') }
end
