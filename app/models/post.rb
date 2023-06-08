class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id # Using classname and foreign key because the association cannot be derived from the foreign key name.
  has_many :comments
  has_many :likes

  scope :update_posts_counter, -> (user){ user.update(posts_counter: user.posts.count) }
  scope :recent_comments, -> (post){ post.comments.order(created_at: :desc).first(5) }
end