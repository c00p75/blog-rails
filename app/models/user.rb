class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Define associations
  # Rails assumes column used to hold the foreign key on this model is the name of the association with the suffix "_id"
  # Using class_name and foreign key because foreign key is not named as suffix "_id"
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments # class_name and foreign key are not neccesary because they are implied.
  has_many :likes

  scope :recent_posts, ->(user) { user.posts.order(created_at: :desc).first(3) }
end
