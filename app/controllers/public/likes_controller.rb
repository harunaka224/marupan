class Public::LikesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post_like = Like.new(end_user_id: current_end_user.id, post_id: params[:post_id])
    @post_like.save
    @post = Post.find(params[:post_id])
    @post.create_notification_by(current_end_user, @post)
  end

  def destroy
    @post_like = Like.find_by(end_user_id: current_end_user.id, post_id: params[:post_id])
    @post_like.destroy
    @post = Post.find(params[:post_id])
  end

end


