FactoryBot.define do
  factory :user do
    name 'John'
    surname 'Spike'
    sequence(:login) { |n| "John #{n}" }
    password 'test123#W'
    password_confirmation 'test123#W'
    sequence(:email) { |n| "test#{n}@gmail.com" }
    kudos_count 0
    birth_date Date.current
  end
end
