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
end
