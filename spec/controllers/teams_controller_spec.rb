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

  context '#new' do
    it "won't render page when unsigned" do
      get :new

      expect(response).to have_http_status(302)
    end

    it 'returns HTTP success' do
      sign_in(user, scope: :user)

      get :new

      expect(response).to have_http_status(200)
    end
  end

  context '#create' do
    it "won't create team when unsigned" do
      params = { name: 'Test', description: 'something we stand for' }

      post :create, params: { team: params }

      expect(response).to have_http_status(302)
    end

    it 'create team with valid params' do
      sign_in(user, scope: :user)

      params = { name: 'Test', description: 'something we stand for' }

      post :create, params: { team: params }

      expect(Team.last.name).to eq(params[:name])
      expect(Team.last.description).to eq(params[:description])
      expect(Team.count).to eq(1)
    end

    it 'does not create team with invalid params' do
      sign_in(user, scope: :user)

      params = { name: 'Test' }

      expect { post :create, params: { team: params } }.to_not change { Team.count }
      expect(subject).to render_template(:new)
    end
  end
end
