class UsersController < ApplicationController
  def index
    # Using instance variable rather than local variables because rails knows to share the variables with erb template.
    @users = User.all # Retrieve all users from Users tabel
  end

  def show
    # Get user by id from database.
    @user = User.find(params[:id]) # Using in-build method, params, to get id from url.
    @user_posts = @user.posts # Retrieve posts belonging to a user
  rescue ActiveRecord::RecordNotFound # Handle record not found error
    redirect_to root_path # Redirect to home if id passed in url does not exist in db.
  end
end
