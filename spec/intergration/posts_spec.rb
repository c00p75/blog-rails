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

  describe 'User post index route: GET /posts' do
    before(:example) do
      visit user_posts_path(@user)
    end

    it "show user's profile picture" do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    it "show user's username" do
      expect(page).to have_content('George R Martin')
    end

    it 'show  number of posts the user has written' do
      expect(page).to have_content('Number of posts: 1')
    end

    it "show the post's title" do
      expect(page).to have_content('post 1')
    end

    it "show  some of the post's body" do
      expect(page).to have_content('content')
    end

    it 'show the first comments on a post' do
      expect(page).to have_content('Great post')
    end

    it 'show the number of comments a post has' do
      expect(page).to have_content('Comments: 1')
    end

    it 'show the number of likes a post has' do
      expect(page).to have_content('Likes: 1')
    end

    it 'when I click on the post title show the post' do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end
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
