class ToppagesController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
    
    unless logged_in?
      @user = User.new
    end
  end
end
