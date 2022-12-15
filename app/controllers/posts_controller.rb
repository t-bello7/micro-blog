class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:author)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render plain: @post.errors.messages
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :title)
  end
end
