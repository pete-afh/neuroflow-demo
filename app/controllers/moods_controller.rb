class MoodsController < ApplicationController
  def create
    MoodRecordService.new(mood_params, current_user).call
    redirect_back fallback_location: moods_path
  end

  def index
    @user = current_user
    redirect_to login_path unless @user
  end

  private

  def mood_params
    params.require(:mood).permit(:name)
  end
end
