describe MoodRecordService do
  it "creates a mood associated with the provided user" do
    user = create(:user)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call
    mood = Mood.last

    expect(mood.name).to eq("happy")
    expect(mood.user).to eq(user)
  end

  it "resets the user's current streak if over a day since last entry" do
    # this should be moved to a daily rake task
    user = create(:user, current_streak: 5)
    create(:mood, user: user, created_at: 5.days.ago)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call

    expect(user.reload.current_streak).to eq(0)
  end

  it "increments current streak if one day after last entry" do
    user = create(:user, current_streak: 5)
    create(:mood, user: user, created_at: 1.day.ago)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call

    expect(user.reload.current_streak).to eq(6)
  end

  it "does nothing if entry is made on same day" do
    user = create(:user, current_streak: 5)
    create(:mood, user: user, created_at: 1.minute.ago)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call

    expect(user.reload.current_streak).to eq(5)
  end

  it "increments longest streak if applicable" do
    user = create(:user, current_streak: 5, longest_streak: 5)
    create(:mood, user: user, created_at: 1.day.ago)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call

    expect(user.reload.longest_streak).to eq(6)
  end

  it "does not increment longest streak if not applicable" do
    user = create(:user, current_streak: 5, longest_streak: 25)
    create(:mood, user: user, created_at: 1.day.ago)
    params = {
      name: "happy"
    }

    described_class.new(params, user).call

    expect(user.reload.longest_streak).to eq(25)
  end
end
