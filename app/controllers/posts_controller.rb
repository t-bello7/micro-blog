class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
    return {@user => @user, @posts => @posts}
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
  end
end
