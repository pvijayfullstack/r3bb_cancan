class PostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new(:post => @post)
  end

  def new
  end

  def edit 
  end
  
  def create
      if @post.save
        flash[:notice] = "Successfully created post."
        redirect_to @post
      else
        render :action => 'new'
      end
  end

 def update
   if @article.update_attributes(params[:article])
     flash[:notice] = "Successfully updated article."
     redirect_to @post
   else
     render :action => 'edit'
   end
  end

  def destroy
    @post.destroy

    flash[:notice] = "Successfully destroyed article."
    redirect_to posts_url
  end
end
