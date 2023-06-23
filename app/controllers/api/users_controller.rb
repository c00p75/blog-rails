class Api::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(current_user.id)
    render json: @user.posts
  end
end
