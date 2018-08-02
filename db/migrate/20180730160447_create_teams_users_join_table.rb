class CreateTeamsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :teams, :users

    add_index :teams_users, :team_id
    add_index :teams_users, :user_id
  end
end
