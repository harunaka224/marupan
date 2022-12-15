class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_end_user.post_comments.new(post_comment_params)
    comment.post_id =@post.id
    comment.save, notice: '投稿にコメントしました'
  end

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id]), alert: 'コメント削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

