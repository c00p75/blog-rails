require 'rails_helper'

RSpec.describe '/users', type: :request do
  before(:all) do
    @user = User.create(name: 'George R Martin', photo: '', bio: 'https//photo.png', posts_counter: 0)
  end

  describe 'GET /index' do
    before(:example) do
      get users_path
    end

    it 'response should be successful' do
      expect(response).to be_successful
    end

    it 'should correctly render index template' do
      expect(response).to render_template(:index)
    end

    it 'should contain placeholder text' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET /show' do
    before(:example) do
      @post = Post.create(author: @user, title: 'post 1', text: 'content', comments_counter: 3, likes_counter: 3)
      get user_path(@user)
    end

    it 'should successfully render response' do
      expect(response).to be_successful
    end

    it 'should correctly render show template' do
      expect(response).to render_template(:show)
    end
    it 'contain the placeholder text' do
      expect(response.body).to include('Here is a specific user')
    end
  end
end
