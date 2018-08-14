class AddWeeklyKudosLimitAndKudosGivenInAWeek < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :weekly_kudos_limit, :integer, default: 7
    add_column :users, :kudos_given_in_a_week, :integer, default: 0
  end
end
