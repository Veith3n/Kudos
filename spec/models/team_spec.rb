require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'adds users to the team and does not add duplicates' do
    team = create(:team)
    user_list = create_list(:user, 3)

    team.users << user_list

    expect(team.users.count).to eq(3)
    expect(team.users.first).to eq(user_list.first)
  end
end
