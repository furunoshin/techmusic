class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def new
    @post = current_user.posts.build
    @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @post.user_id)
    favorite_counts(@post)
  end
  
  
  def create
    @users = User.all
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '記事を投稿しました。'
      redirect_to post_path(@post.id)
    else
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '記事の投稿に失敗しました。'
      render new_post_path
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @users = User.all
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '記事が更新されました。'
      redirect_to post_path(@post.id)
    else
      flash.now[:danger] = '記事の更新に失敗しました。'
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to user_path(current_user.id)
  end
  
  def search
  #ViewのFormで取得したパラメータをモデルに渡す
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page])
  end



  private

  def post_params
    params.require(:post).permit(:content, :tag, :title)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end