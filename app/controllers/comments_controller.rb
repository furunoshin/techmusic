class CommentsController < ApplicationController
before_action :require_user_logged_in
  
  def create
    @post=Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      render user_path(current_user.id)
    end
  
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
     redirect_to  request.referrer || root_url
  end

  private 

  def comment_params
    params.require(:comment).permit(:content)
  end


end

