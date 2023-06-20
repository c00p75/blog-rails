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

  describe 'user show page at route: GET /users/:id' do
    before(:example) do
      visit user_path(@user)
    end

    it "shows the user's profile picture" do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    it "shows the user's name" do
      expect(page).to have_content('George R Martin')
    end

    it 'shows the number of posts the user has' do
      expect(page).to have_content('Number of posts: 1')
    end

    it "shows the user's bio" do
      expect(page).to have_content('Writter')
    end

    it "shows the user's first 3 posts" do
      Post.create(author: @user, title: 'post 2', text: 'content', comments_counter: 1, likes_counter: 1)
      Post.create(author: @user, title: 'post 3', text: 'content', comments_counter: 1, likes_counter: 1)
      Post.create(author: @user, title: 'post 4', text: 'content', comments_counter: 1, likes_counter: 1)
      visit user_path(@user)
      expect(page.find_all('li h2').length).to eq(3)
    end

    it "shows a button to see all of the user's posts" do
      expect(page.find(:xpath, '//button[1]').text).to eq('See all posts')
    end

    it "redirects to post's show page when user's post is clicked" do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end

    it "redirects me to a page with all of the user's posts when button to see all of the user's posts is clicked" do
      find('a.more').click
      sleep 1
      expect(current_path).to eq user_posts_path(@user)
    end
  end
end
