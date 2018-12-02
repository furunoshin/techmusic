class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :user, :edit, :update, :destroy, :followings, :followers, :likes]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @ranking_counts = Favorite.ranking
    @posts = Post.find(@ranking_counts.keys)
    @ranking_counts = Relationship.ranking
    @users = User.find(@ranking_counts.keys)
    
    unless logged_in?
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @ranking_counts = Favorite.ranking
    @posts = Post.find(@ranking_counts.keys)
    @ranking_counts = Relationship.ranking
    @users = User.find(@ranking_counts.keys)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報が更新されました。'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ユーザー情報の更新に失敗しました。'
      redirect_to user_path(@user.id)
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end
  
  def like_comments
    @user = User.find(params[:id])
    @like_comments = @user.like_comments.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :site_url )
  end
end