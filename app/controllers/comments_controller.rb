class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to post_path(@post)
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to post_path(@comment.post_id)
  end
end
