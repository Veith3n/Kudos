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
  end

  context '#profile and #update_profile' do
    let(:user) do
      create(:user)
    end
    let(:other_user) do
      create(:user)
    end

    it 'update user date' do
      sign_in(user, scope: :user)

      params = { name: 'New value', surname: user.surname, birth_date: user.birth_date }

      post :update_profile, params: { id: user.id, user: params }
      user.reload

      expect(user.name).to eq(params[:name])
    end

    it "won't update with incorrect data" do
      sign_in(user, scope: :user)

      params = { name: '', surname: user.surname, birth_date: user.birth_date }

      post :update_profile, params: { id: user.id, user: params }
      user.reload

      expect(user.name).to_not eq(params[:name])
    end

    it "won't update data for other user" do
      sign_in(user, scope: :user)

      params = { name: 'New', surname: user.surname, birth_date: user.birth_date }

      post :update_profile, params: { id: other_user.id, user: params }
      other_user.reload

      expect(other_user.name).to_not eq(params[:name])
    end
  end

  context '#top_ten' do
    it('returns correct 10 users') do
      top_ten_users_list = create_list(:user, 10)
      other_users = create_list(:user, 15)

      top_ten_users_list.each do |user|
        Kudo.create(giver: user, receiver: user)
      end

      get :top_ten

      expect(assigns(:users)).to match_array(top_ten_users_list)
    end
  end
end
