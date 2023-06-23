class Api::CommentsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    render json: @post.comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @user = User.find(current_user.id)
    @post = Post.find(@user.id)
    @comment = Comment.new(user_id: @user.id, post_id: @post.id, text: params[:text])

    if @comment.save
        @comments = Comment.all
      render json: @comments
    else
      render json: { errors: @comment.errors.full_messages }
    end
  end
end
