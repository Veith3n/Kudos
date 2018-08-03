FactoryBot.define do
  factory :user do
    name 'John'
    surname 'Spike'
    password 'test123#W'
    password_confirmation 'test123#W'
    sequence(:email) { |n| "test#{n}@gmail.com" }
    kudos_count 0
    birth_date Date.current
    terms_of_service true
  end
end
