class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    @post.save
    redirect_to posts_path
  end

  def show

  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body, :shop_name)
  end

end
