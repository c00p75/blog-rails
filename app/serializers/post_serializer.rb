class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text
  has_many :comments
end
