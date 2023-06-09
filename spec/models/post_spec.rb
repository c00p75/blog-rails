require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:example) do
    @user = User.create(name: 'George R Martin', photo: '', bio: 'https//photo.png', posts_counter: 0)
    @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 3, likes_counter: 3)
  end

  describe 'Validations' do
    it 'title must not be blank' do
      @post.title = nil
      expect(@post).to_not be_valid
    end
  
    it 'comments_counter must not be a non-integer' do
      @post.comments_counter = 'one'
      expect(@post).to_not be_valid
    end
  
    it 'comments_counter must be an integer greater or equal to 0' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end
  
    it 'likes_counter must not be a non-integer' do
      @post.likes_counter = 'one'
      expect(@post).to_not be_valid
    end
  
    it 'like_counter must be an integer greater or equal to 0' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end
  end
  
  describe 'scopes' do
    it 'recent posts count should be 3' do
      Comment.create(user: @user, text: 'comment 1', post: @post)
      Comment.create(user: @user, text: 'comment 2', post: @post)
      Comment.create(user: @user, text: 'comment 3', post: @post)
      Comment.create(user: @user, text: 'comment 4', post: @post)
      Comment.create(user: @user, text: 'comment 5', post: @post)
      Comment.create(user: @user, text: 'comment 6', post: @post)
      expect(Post.recent_comments(@post).count).to eq(5)
    end
  end
end