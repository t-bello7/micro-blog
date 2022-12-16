class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @users = User.all
  end

  def show
    @post = Post.new
    @user = User.find(params[:id])
  end
end
