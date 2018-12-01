class ToppagesController < ApplicationController
  def index
    @ranking_counts = Favorite.ranking
    @posts = Post.find(@ranking_counts.keys)
    @ranking_counts = Relationship.ranking
    @users = User.find(@ranking_counts.keys)
    
    unless logged_in?
      @user = User.new
    end
  end
end
