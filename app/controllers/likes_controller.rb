class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(post: @post, author: current_user)
    if @like.save
      redirect_to request.referrer
    else
      render plain: @like.errors.messages
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
