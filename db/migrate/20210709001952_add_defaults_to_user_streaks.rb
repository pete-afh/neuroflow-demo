class AddDefaultsToUserStreaks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :current_streak, from: nil, to: 0
    change_column_default :users, :longest_streak, from: nil, to: 0
  end
end
