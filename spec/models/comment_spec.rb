require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:context) do
    @user = User.create(name: 'George R Martin', photo: '', bio: 'https//photo.png', posts_counter: 0)
    @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 3, likes_counter: 3)
    @comment = Comment.create(user: @user, text: 'comment 1', post: @post)
  end

  describe 'References' do
    it 'References correct user' do
      expect(User.find(@comment.user_id)).to eq(@user)
    end
  
    it 'Reference correct post' do
      expect(Post.find(@comment.post_id)).to eq(@post)
    end
  end

  describe 'scopes' do
    it 'test if comment counter is updated' do
      Comment.create(user: @user, text: 'comment 2', post: @post)
      Comment.create(user: @user, text: 'comment 3', post: @post)
      Comment.update_comments_counter(@post)
      expect(@post.comments_counter).to eq(3)
    end
  end
end
