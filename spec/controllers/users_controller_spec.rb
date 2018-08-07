require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context '#index' do
    it 'returns HTTP success' do
      get :index, params: {}

      expect(response).to have_http_status(200)
    end

    it 'returns all created Users' do
      create_list(:user, 3)

      get :index, params: {}

      expect(assigns(:users)).to match_array(User.all)
    end
  end

  context '#give_kudo' do
    before do
      request.env['HTTP_REFERER'] = 'http://example.com'
    end

    let(:team) do
      create(:team)
    end
    let(:user) do
      create(:user)
    end
    let(:team_member) do
      create(:user)
    end

    it 'add kudo to the team member' do
      sign_in(user, scope: :user)

      team.users << [user, team_member]

      get :give_kudo, params: { id: team_member.id }
      team_member.reload

      expect(team_member.received_kudos.count).to eq(1)
    end

    it "won't give kudo to the same user again" do
      sign_in(user, scope: :user)

      team.users << [user, team_member]

      get :give_kudo, params: { id: team_member.id }
      team_member.reload
      user.reload

      get :give_kudo, params: { id: team_member.id }

      expect(team_member.received_kudos.count).to eq(1)
    end

    it "won't give kudo to a user that is not in the same team" do
      sign_in(user, scope: :user)

      team.users << user

      get :give_kudo, params: { id: team_member.id }
      team_member.reload

      expect(team_member.received_kudos.count).to eq(0)
    end

    it "won't give kudo if user is not logged in" do
      team.users << [user, team_member]

      get :give_kudo, params: { id: team_member.id }
      team_member.reload

      expect(team_member.received_kudos.count).to eq(0)
    end

    it "won't give kudo to yourself" do
      sign_in(user, scope: :user)

      get :give_kudo, params: { id: user.id }
      user.reload

      expect(user.received_kudos.count).to eq(0)
    end

    it "won't give more kudos than weekly limit" do
      sign_in(user, scope: :user)
      user.weekly_kudos_limit = 7
      user.kudos_given_in_a_week = 7

      team.users << [user, team_member]

      get :give_kudo, params: { id: team_member.id }
      team_member.reload

      expect(team_member.received_kudos.count).to eq(0)
    end

  end
end
