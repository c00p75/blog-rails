class PostsController < ApplicationController
  def index
    @posts = "Here is a list of posts by user."
  end

  def show
   @post = "Here is user's post with id " + params[:id]
  end
end