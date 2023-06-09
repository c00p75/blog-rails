require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:context) do
    @user = User.create(name: 'George R Martin', photo: '', bio: 'https//photo.png', posts_counter: 0)
    @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 3, likes_counter: 3)
    @like = Like.create(user: @user, post: @post)
  end

  describe 'References' do
    it 'References correct user' do
      expect(User.find(@like.user_id)).to eq(@user)
    end

    it 'Reference correct post' do
      expect(Post.find(@like.post_id)).to eq(@post)
    end
  end

  describe 'scopes' do
    it 'test if likes counter is updated' do
      Like.create(user: @user, post: @post)
      Like.create(user: @user, post: @post)
      Like.update_likes_counter(@post)
      expect(@post.likes_counter).to eq(3)
    end
  end
end
