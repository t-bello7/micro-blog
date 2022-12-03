class UsersController < ApplicationController
  def index 
    @users = User.all
  end

  def show
    @post = Post.new
    @user = User.find(params[:id])
  end
end
