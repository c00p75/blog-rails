class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :update_likes_counter, -> (post){ post.update(likes_counter: post.likes.count) }
end
