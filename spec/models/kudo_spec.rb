require 'rails_helper'

RSpec.describe Kudo, type: :model do
  let(:giver) do
    create(:user)
  end
  let(:receiver) do
    create(:user)
  end
  let(:receiver2) do
    create(:user)
  end
  it 'create kudo' do
    Kudo.create(giver: giver, receiver: receiver)
    Kudo.create(giver: giver, receiver: receiver2)

    expect(Kudo.count).to eq(2)
    expect(giver.given_kudos.count).to eq(2)
    expect(receiver.received_kudos.count).to eq(1)
    expect(receiver2.received_kudos.count).to eq(1)
  end
end
