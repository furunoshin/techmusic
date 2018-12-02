class CommentsController < ApplicationController
before_action :require_user_logged_in
  
  def create
    @post=Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to post_path(@post)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_to post_path(@post)
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