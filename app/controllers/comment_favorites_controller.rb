class CommentFavoritesController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    current_user.like_comment(comment)
    flash[:success] = 'いいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    current_user.unlike_comment(comment)
    flash[:success] = 'いいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
