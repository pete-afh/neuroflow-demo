class MoodRecordService
  attr_reader :params
  attr_accessor :user

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    last_entry_date = user.moods.last&.created_at&.beginning_of_day || 0
    mood = Mood.create(name: params[:name], user: user)
    current_entry_date = mood.created_at.beginning_of_day

    if current_entry_date > last_entry_date + 1.day
      # should be in a daily rake task, but for demo purposes here
      user.current_streak = 0
    elsif current_entry_date == last_entry_date
      return
    else
      user.current_streak += 1
      user.longest_streak = user.current_streak if user.current_streak > user.longest_streak
    end

    user.save
  end
end
