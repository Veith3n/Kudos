FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    description 'yup'
  end
end