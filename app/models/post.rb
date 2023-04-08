class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :content, :post_type, :author_id, :author, presence: true
end
