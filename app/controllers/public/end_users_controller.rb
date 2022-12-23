class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  before_action :ensure_guest_end_user, only: [:edit]

  def index
    redirect_to new_end_user_registration_path
  end

  def show
    @end_user = EndUser.find(params[:id])
    @post = @end_user.posts.page(params[:page]).per(9)
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user)
    else
      render edit
    end
  end

  def quit
  end

  def out
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: "退会しました"
  end

  def likes
    @end_user = EndUser.find(params[:id])
    likes = Like.where(end_user_id: @end_user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :profile_image)
  end


  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.name == "guest"
      redirect_to end_user_path(current_end_user), notice: 'ゲストユーザーはプロフィールを編集できません'
    end
  end
end
