class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

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
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id), notice: "投稿更新しました"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, alert: "投稿削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body, :shop_name)
  end

end
