class Public::PostCommentsController < ApplicationController
  before_action :authenticate_end_user!
  #before_action :ensure_guest_end_user, only: [:create, :update]

  def create
    @post = Post.find(params[:post_id])
    comment = current_end_user.post_comments.new(post_comment_params)
    comment.post_id =@post.id
    comment.save
    comment.post.create_notification_comment!(current_end_user, comment, comment.post_id)
    @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(9)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(9)
    @post_comment = @post.post_comments.find(params[:id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  # def ensure_guest_end_user
  #   @post = Post.find(params[:post_id])
  #   if current_end_user.name == "guest"
  #     redirect_to post_path(@post.id), notice: 'ゲストユーザーはコメントできません。'
  #   end
  # end
end

