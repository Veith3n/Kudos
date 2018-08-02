require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:team) do
    create(:team)
  end
  let(:user) do
    create(:user)
  end

  context '#show' do
    it 'returns HTTP success' do
      team = create(:team)

      get :show, params: { id: team.id }

      expect(response).to have_http_status(200)
    end
  end

  context '#add_member #remove_member' do
    it 'add member to the team and remove him from the team' do
      sign_in(user, scope: :user)
      get :add_member, params: { id: team.id }

      expect(team.users.count).to eq(1)

      get :remove_member, params: { id: team.id }

      expect(team.users.count).to eq(0)
    end

    it 'does not add the same member again to the team' do
      sign_in(user, scope: :user)

      get :add_member, params: { id: team.id }
      get :add_member, params: { id: team.id }

      expect(team.users.count).to eq(1)
    end

    it 'unsigned user can not add member to the team' do
      get :add_member, params: { id: team.id }

      expect(team.users.count).to eq(0)
    end
  end
end
