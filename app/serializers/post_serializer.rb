class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :post_type, :author, :created_at, :updated_at
end
