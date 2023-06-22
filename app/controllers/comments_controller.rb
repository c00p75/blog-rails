class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params.merge(user: @user, post: @post))
    if @comment.save
      Comment.update_comments_counter(@post)
      redirect_to user_post_path(@post.author_id, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    return unless @comment.destroy

    redirect_to user_post_path(@user, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
