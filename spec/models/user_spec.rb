require 'rails_helper'

RSpec.describe User, type: :user do
  before(:all) do
    @user = User.create(name: 'John Doe', photo: 'live to photo', bio: 'live to bio', posts_counter: 0)
  end

  describe 'Validations' do
    it 'name must not be blank' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'posts_counter must not be a non-integer' do
      @user.posts_counter = 'five'
      expect(@user).to_not be_valid
    end

    it 'posts_counter must be an integer greater or equal to 0' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end

  describe 'scopes' do
    it 'recent posts count should be 3' do
      Post.create( author: @user, title: 'post 1', text: 'content', comments_counter: 3, likes_counter: 3)
      Post.create( author: @user, title: 'post 2', text: 'content', comments_counter: 3, likes_counter: 3)
      Post.create( author: @user, title: 'post 3', text: 'content', comments_counter: 3, likes_counter: 3)
      Post.create( author: @user, title: 'post 3', text: 'content', comments_counter: 3, likes_counter: 3)
      expect(User.recent_posts(@user).count).to eq(3)
    end
  end
end
