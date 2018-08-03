require 'rails_helper'

RSpec.describe User, type: :model do
  context 'create user' do
    it 'can not create user with missing data' do
      user = User.new(name: nil)

      expect(user).to_not be_valid()
    end
  end
end