class Api::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.find(@user.id)
    render json: @posts
  end

  def show
    @post = Post.find(params[:post_id])
    render json: @post
  end
end
