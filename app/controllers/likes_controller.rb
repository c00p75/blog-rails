class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user: @user, post: @post)
    if @like.save
      Like.update_likes_counter(@post)
      redirect_to user_post_path(@post.author_id, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
