class FavoritesController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like(micropost)
    flash[:success] = 'いいねしました。'
    redirect_to("/users/#{micropost.user.id}")
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    flash[:success] = 'いいねを解除しました。'
    redirect_to("/users/#{micropost.user.id}")
  end
end
