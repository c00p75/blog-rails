require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:context) do
    @user = User.create(name: 'George R Martin',
                        photo: 'https://media.vanityfair.com/photos/62fa8f172d8966f073e581bb/master/w_2560%2Cc_limit/george-r-r-martin-portrait-redux.jpg',
                        bio: 'Writter', posts_counter: 0)
    @user2 = User.create(name: 'Lee harmer',
                         photo: 'https://www.hollywoodreporter.com/wp-content/uploads/2013/10/harper_lee.jpg',
                         bio: 'American novelist', posts_counter: 0)
    @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 1, likes_counter: 1)
    @comment = Comment.create(user: @user2, text: 'Great post', post: @post)
    @like = Like.create(user: @user, post: @post)
  end

  describe 'post show route: GET /posts/:id' do
    before(:example) do
      visit user_post_path(@user, @post)
    end

    it 'show the post title' do
      expect(page).to have_content('post 1')
    end

    it 'show who wrote the post' do
      expect(page).to have_content('George R Martin')
    end

    it 'show how many comments the post has' do
      expect(page).to have_content('Comments: 1')
    end

    it 'show how many likes the post has' do
      expect(page).to have_content('Likes: 1')
    end

    it 'show the post body' do
      expect(page).to have_content('post 1')
    end

    it 'show the username of each commentor' do
      expect(page).to have_content('Lee harmer')
    end

    it "show the comment's content" do
      expect(page).to have_content('Great post')
    end
  end
end
