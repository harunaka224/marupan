class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_end_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(9)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, alert: "投稿削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:image, :title, :body, :shop_name)
  end

  def ensure_end_user
    @posts = current_end_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end
end