class RankingsController < ApplicationController
  def favorite
    @ranking_counts = favorite.ranking
    @posts = Post.find(@ranking_counts.keys)
  end
end
