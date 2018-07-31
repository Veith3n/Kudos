require 'rails_helper'

RSpec.describe User, type: :model do
  it 'adds team to the user and does not add duplicates' do
    user = create(:user)
    team_list = create_list(:team, 3)

    user.teams << team_list
    user.teams << team_list

    expect(user.teams.count).to eq(3)
    expect(user.teams.first).to eq(team_list.first)
  end
end
