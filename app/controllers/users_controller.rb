class UsersController < ApplicationController
  def index
    return redirect_to moods_path if current_user
  end

  def new
    return redirect_to moods_path if current_user
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to moods_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
