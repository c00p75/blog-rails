require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before(:context) do
    @user = User.create(name: 'George R Martin',
                        photo: 'https://media.vanityfair.com/photos/62fa8f172d8966f073e581bb/master/w_2560%2Cc_limit/george-r-r-martin-portrait-redux.jpg',
                        bio: 'Writter', posts_counter: 0)
    @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 1, likes_counter: 1)
    @comment = Comment.create(user: @user, text: 'comment 1', post: @post)
    @like = Like.create(user: @user, post: @post)
  end

  describe 'user index page at route: GET /users' do
    before(:example) do
      visit users_path
    end

    it 'shows the username for all users' do
      expect(page).to have_content('George R Martin')
    end

    it 'shows the profile picture for each user' do
      expect(page).to have_selector('img.card-img[alt="photo"]', visible: true)
    end

    it 'shows the number of posts each user  has written' do
      expect(page).to have_content('Number of posts: 1')
    end

    it "shows posts when user's name is clicked" do
      find("a[href='/users/#{@user.id}']").click
      sleep 1
      expect(current_path).to eq user_path(@user)
    end
  end
end
