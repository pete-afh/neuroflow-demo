require "rails_helper"

RSpec.describe User do
  describe "longest_streak_percentile" do
    it "returns the closest whole integer of a user's longest streak percentile" do
      days = [77, 76, 88, 85, 87, 78, 80, 95, 90, 83, 89, 93, 75, 70, 67]
      days.each do |num|
        create(:user, longest_streak: num)
      end
      user1 = User.find_by(longest_streak: 88)
      user2 = User.find_by(longest_streak: 67)
      user3 = User.find_by(longest_streak: 95)

      expect(user1.longest_streak_percentile).to eq(67)
      expect(user2.longest_streak_percentile).to eq(0)
      expect(user3.longest_streak_percentile).to eq(94)
    end
  end
end
