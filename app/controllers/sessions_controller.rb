class SessionsController < ApplicationController
  def create
    return redirect_to moods_path if current_user

    @user = User.find_by_email(session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to moods_path
    else
      redirect_to signup_path
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
