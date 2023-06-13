class UsersController < ApplicationController
  def index
    @users = "Here is a list of users"
  end

  def show
   @user = "Here is user with id " + params[:id]
  end
end