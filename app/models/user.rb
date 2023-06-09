class User < ApplicationRecord
  # Define associations
  # Rails assumes column used to hold the foreign key on this model is the name of the association with the suffix "_id"
  # Using class_name and foreign key because foreign key is not named as suffix "_id"
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments # class_name and foreign key are not neccesary because they are implied.
  has_many :likes

  scope :recent_posts, ->(user) { user.posts.order(created_at: :desc).first(3) }
end
