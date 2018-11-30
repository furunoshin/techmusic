class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.count
    @count_like_comments = user.like_comments.count
  end
  
  def favorite_counts(post)
    # @count_iine = Favorite.where(post_id: post.id).count
    @count_iine = post.favorites.count
  end
end
