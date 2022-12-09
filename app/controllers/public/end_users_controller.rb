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


  private

  def end_user_params
    params.require(:end_user).permit(:name, :profile_image)
  end
end
