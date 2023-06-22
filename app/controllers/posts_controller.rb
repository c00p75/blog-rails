class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    # Finds current user based on url. This variable is is used in form_with url
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user # Finds current user based in url
    # creates a new post object with the permitted parameters (:title and :text)
    # and merge them with author and comments and likes counters
    @post = Post.new(post_params.merge(author: @user, comments_counter: 0, likes_counter: 0))

    if @post.save
      redirect_to user_post_path(@post.author_id, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    # Check if the current user is authorized to delete the post
    authorize! :destroy, @post

    # Delete associated likes and comments
    @post.likes.destroy_all
    @post.comments.destroy_all

    return unless @post.destroy

    redirect_to user_path(User.find(params[:user_id]))
  end

  private

  # Using strong parameters to enforce parameter whitelisting and improve security.
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
