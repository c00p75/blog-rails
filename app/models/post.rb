class Post < ApplicationRecord
  belongs_to :user, class_name: "User"    # Using classname because the association cannot be derived from the foreign key name.
  has_many :comments
  has_many :likes
end