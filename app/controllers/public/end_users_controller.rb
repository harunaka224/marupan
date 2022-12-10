class Public::EndUsersController < ApplicationController

  def show
    @end_user = current_end_user
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
    flash[:notice] = "退会しました"
    redirect_to root_path
  end


  private

  def end_user_params
    params.require(:end_user).permit(:name, :profile_image)
  end
end
