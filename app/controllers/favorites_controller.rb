class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = 'いいねしました。'
    redirect_to("/users/#{post.user.id}")
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:success] = 'いいねを解除しました。'
    redirect_to("/users/#{post.user.id}")
  end
end
