class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Using classname and foreign key because the association cannot be derived from the foreign key name.
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  scope :update_posts_counter, ->(user) { user.update(posts_counter: user.posts.count) }
  scope :recent_comments, ->(post) { post.comments.order(created_at: :desc).first(5) }
end
