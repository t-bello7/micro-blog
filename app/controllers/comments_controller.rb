class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: comment_params[:text], author: current_user)
    if @comment.save
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      render plain: @comment.errors.messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
