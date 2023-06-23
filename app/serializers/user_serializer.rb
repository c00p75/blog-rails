class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo, :bio, :posts_counter, :email
  # has_many :posts
end
