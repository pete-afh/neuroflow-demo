class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :moods

  def longest_streak_percentile
    streaks = User.all.pluck(:longest_streak).sort
    user_idx = streaks.index(self.longest_streak)
    percentile = (100 * (user_idx.to_f / streaks.length)).ceil
  end
end
